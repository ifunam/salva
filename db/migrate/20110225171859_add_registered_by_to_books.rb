class AddRegisteredByToBooks < ActiveRecord::Migration
  def self.up
    if column_exists?  :books, :moduser_id
      rename_column :books, :moduser_id, :registered_by_id
    else
      add_column :books, :registered_by_id, :integer
    end

    add_column :books, :modified_by_id, :integer
  end

  def self.down
    rename_column :books, :registered_by_id, :moduser_id
    remove_column :books, :modified_by_id
  end
end
