class AddRegisteredByToActivitytypes < ActiveRecord::Migration
  def self.up
    rename_column :activitytypes, :moduser_id, :registered_by_id
    add_column :activitytypes, :modified_by_id, :integer
  end

  def self.down
    rename_column :activitytypes, :registered_by_id, :moduser_id
    remove_column :activitytypes, :modified_by_id
  end
end
