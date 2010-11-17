class AddRegisteredByToPublishers < ActiveRecord::Migration
  def self.up
    rename_column :publishers, :moduser_id, :registered_by_id
    add_column :publishers, :modified_by_id, :integer
  end

  def self.down
    rename_column :publishers, :registered_by_id, :moduser_id
    remove_column :publishers, :modified_by_id
  end
end
