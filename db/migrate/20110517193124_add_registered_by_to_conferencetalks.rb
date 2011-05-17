class AddRegisteredByToConferencetalks < ActiveRecord::Migration
  def self.up
    if column_exists?  :conferencetalks, :moduser_id
      rename_column :conferencetalks, :moduser_id, :registered_by_id
    else
      add_column :conferencetalks, :registered_by_id, :integer
    end
    add_column :conferencetalks, :modified_by_id, :integer
  end

  def self.down
    rename_column :conferencetalks, :registered_by_id, :moduser_id
    remove_column :conferencetalks, :modified_by_id
  end
end
