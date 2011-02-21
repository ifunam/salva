class AddRegisteredByToTutorialCommittees < ActiveRecord::Migration
   def self.up
    if column_exists?  :tutorial_committees, :moduser_id
      rename_column :tutorial_committees, :moduser_id, :registered_by_id
    else
      add_column :tutorial_committees, :registered_by_id, :integer
    end

    add_column :tutorial_committees, :modified_by_id, :integer
  end

  def self.down
    rename_column :tutorial_committees, :registered_by_id, :moduser_id
    remove_column :tutorial_committees, :modified_by_id
  end
end
