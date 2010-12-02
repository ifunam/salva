class AddRegisteredByToGenericworks < ActiveRecord::Migration
  def self.up
    if column_exists? :genericworks, :moduser_id
      rename_column :genericworks, :moduser_id, :registered_by_id
    else
      add_column :genericworks, :registered_by_id, :integer
    end

    add_column :genericworks, :modified_by_id, :integer
  end

  def self.down
    rename_column :articles, :registered_by_id, :moduser_id
    remove_column :articles, :modified_by_id
  end
end
