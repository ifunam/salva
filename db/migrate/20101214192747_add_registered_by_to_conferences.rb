class AddRegisteredByToConferences < ActiveRecord::Migration
  def self.up
    if column_exists? :conferences, :moduser_id
      rename_column :conferences, :moduser_id, :registered_by_id
    else
      add_column :conferences, :registered_by_id, :integer
    end

    add_column :conferences, :modified_by_id, :integer
  end

  def self.down
    rename_column :conferences, :registered_by_id, :moduser_id
    remove_column :conferences, :modified_by_id
  end
end
