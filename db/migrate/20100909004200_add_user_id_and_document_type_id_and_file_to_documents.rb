class AddUserIdAndDocumentTypeIdAndFileToDocuments < ActiveRecord::Migration
  def self.up
    add_column :documents, :user_id, :integer
    add_column :documents, :document_type_id, :integer
    add_column :documents, :file, :string
  end

  def self.down
    [:user_id, :document_type_id, :file].each do |column_name|
      remove_column :documents, column_name
    end
  end
end
