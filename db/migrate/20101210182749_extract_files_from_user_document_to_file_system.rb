class ExtractFilesFromUserDocumentToFileSystem < ActiveRecord::Migration
  def self.up
    base_path = Rails.root.to_s + '/public/uploads'
    UserDocument.select('id, document_id, user_id, documenttype_id, created_on, updated_on').all.each do |record|
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
      @document = Document.create(:user_id => record.user_id, :documenttype_id => record.documenttype_id,
                                  :registered_by_id => record.user_id, :created_on => record.created_on,
                                  :updated_on => record.updated_on, :file => filename)
    end
  end

  def self.down
  end
end
