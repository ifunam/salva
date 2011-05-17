class AddRegisteredByToUserConferencetalks < ActiveRecord::Migration
    def self.up
    if column_exists?  :user_conferencetalks, :moduser_id
      rename_column :user_conferencetalks, :moduser_id, :registered_by_id
    else
      add_column :user_conferencetalks, :registered_by_id, :integer
    end
    add_column :user_conferencetalks, :modified_by_id, :integer
  end

  def self.down
    rename_column :user_conferencetalks, :registered_by_id, :moduser_id
    remove_column :user_conferencetalks, :modified_by_id
  end
end
