class ExtractFilesFromUserDocumentToFileSystem < ActiveRecord::Migration
  def self.up
    base_path = Rails.root.to_s + '/public/uploads'

    timestamp_columns = %w(created_at updated_at)
    if (column_exists? :user_documents, :created_on) and (column_exists? :user_documents, :updated_on)
      timestamp_columns = %w(created_on updated_on)
    end
    columns = %w(id document_id user_id documenttype_id user_incharge_id) + timestamp_columns

    UserDocument.select(columns.join(', ')).all.each do |record|
      path = base_path + "/#{record.user.login}"
      if record.document.documenttype.name == 'Informe anual de actividades'
        path = base_path + '/annual_reports/' + record.document.title.to_s
      elsif record.document.documenttype.name == 'Plan de trabajo'
        path = base_path + '/annual_plan/' + record.document.title.to_s
      end
      unless File.exist? path
        puts "Creating directory: #{path}"
        system "mkdir -p #{path}"
      end
      filename = path + "/#{record.user.login}.pdf"
      unless File.exist? filename
        puts "Creating file: #{filename}"
        @user_document = UserDocument.find(record.id)
        File.open(filename, 'w') do |f|
          f.write @user_document.file
        end
      end
      puts "Inserting document: :user_id => #{record.user_id}, :file => #{filename}"
      file_signature = Digest::MD5.hexdigest(filename)
      @document = Document.create(:user_id => record.user_id, :documenttype_id => record.documenttype_id,
                                  :registered_by_id => record.user_id, :created_on => record.created_on,
                                  :updated_on => record.updated_on, :file => filename,
                                  :approved_by_id => record.user_incharge_id, :approved => true,
                                  :signature => file_signature)
    end
  end

  def self.down
  end
end
