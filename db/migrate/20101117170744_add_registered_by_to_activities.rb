class AddRegisteredByToActivities < ActiveRecord::Migration
  def self.up
    if column_exists? :activities, :moduser_id
      rename_column :activities, :moduser_id, :registered_by_id
    else
      add_column :activities, :registered_by_id, :integer
    end

    add_column :activities, :modified_by_id, :integer
  end

  def self.down
    rename_column :activities, :registered_by_id, :moduser_id
    remove_column :activities, :modified_by_id
  end
end
