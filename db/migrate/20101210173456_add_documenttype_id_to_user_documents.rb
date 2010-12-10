class AddDocumenttypeIdToUserDocuments < ActiveRecord::Migration
  def self.up
    add_column :user_documents, :documenttype_id, :integer
  end

  def self.down
    remove_column :user_documents, :documenttype_id
  end
end
