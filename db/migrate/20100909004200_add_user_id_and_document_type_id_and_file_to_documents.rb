class AddUserIdAndDocumentTypeIdAndFileToDocuments < ActiveRecord::Migration
  def self.up
    [ :user_id, :document_type_id ].each do |column|
      unless column_exists? :documents, column 
        add_column :documents, column, :integer
      end
    end

    add_column :documents, :file, :string
  end
  
  def self.down
    [:user_id, :document_type_id, :file].each do |column_name|
      remove_column :documents, column_name
    end
  end
end
