class AddIsHiddenToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :is_hidden, :boolean
  end
end
