class AddRegisteredByToDocuments < ActiveRecord::Migration
  def self.up
    if column_exists? :documents, :moduser_id
      rename_column :documents, :moduser_id, :registered_by_id
    else
      add_column :documents, :registered_by_id, :integer
    end

    add_column :documents, :modified_by_id, :integer
  end

  def self.down
    rename_column :documents, :registered_by_id, :moduser_id
    remove_column :documents, :modified_by_id
  end
end
