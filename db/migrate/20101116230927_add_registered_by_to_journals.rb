class AddRegisteredByToJournals < ActiveRecord::Migration
  def self.up
    if column_exists? :journals, :moduser_id
      rename_column :journals, :moduser_id, :registered_by_id
    else
      add_column :journals, :registered_by_id, :integer
    end

    add_column :journals, :modified_by_id, :integer
  end

  def self.down
    rename_column :journals, :registered_by_id, :moduser_id
    remove_column :journals, :modified_by_id
  end
end
