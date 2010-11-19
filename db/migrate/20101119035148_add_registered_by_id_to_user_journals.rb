class AddRegisteredByIdToUserJournals < ActiveRecord::Migration
  def self.up
    rename_column :user_journals, :moduser_id, :registered_by_id
    add_column :user_journals, :modified_by_id, :integer
  end

  def self.down
    rename_column :user_journals, :registered_by_id, :moduser_id
    remove_column :user_journals, :modified_by_id
  end
end
