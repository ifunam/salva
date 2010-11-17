class AddRegisteredByToActivities < ActiveRecord::Migration
  def self.up
    rename_column :activities, :moduser_id, :registered_by_id
    add_column :activities, :modified_by_id, :integer
  end

  def self.down
    rename_column :activities, :registered_by_id, :moduser_id
    remove_column :activities, :modified_by_id
  end
end
