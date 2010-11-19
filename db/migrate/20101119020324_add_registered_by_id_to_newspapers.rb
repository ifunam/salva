class AddRegisteredByIdToNewspapers < ActiveRecord::Migration
  def self.up
    rename_column :newspapers, :moduser_id, :registered_by_id
    add_column :newspapers, :modified_by_id, :integer
  end

  def self.down
    rename_column :newspapers, :registered_by_id, :moduser_id
    remove_column :newspapers, :modified_by_id
  end
end
