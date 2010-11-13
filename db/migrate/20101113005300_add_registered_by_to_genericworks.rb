class AddRegisteredByToGenericworks < ActiveRecord::Migration
  def self.up
    rename_column :genericworks, :moduser_id, :registered_by_id
    add_column :genericworks, :modified_by_id, :integer
  end

  def self.down
    rename_column :articles, :registered_by_id, :moduser_id
    remove_column :articles, :modified_by_id
  end
end
