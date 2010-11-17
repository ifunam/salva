class AddRegisteredByToInstitutionalActivities < ActiveRecord::Migration
  def self.up
    rename_column :institutional_activities, :moduser_id, :registered_by_id
    add_column :institutional_activities, :modified_by_id, :integer
  end

  def self.down
    rename_column :institutional_activities, :registered_by_id, :moduser_id
    remove_column :institutional_activities, :modified_by_id
  end
end
