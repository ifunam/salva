class AddSignatureToDocuments < ActiveRecord::Migration
  def self.up
    add_column :documents, :signature, :text
  end

  def self.down
    remove_column :documents, :signature
  end
end
