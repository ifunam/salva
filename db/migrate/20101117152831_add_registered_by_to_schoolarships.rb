class AddRegisteredByToSchoolarships < ActiveRecord::Migration
  def self.up
    if column_exists?  :schoolarships, :moduser_id
      rename_column :schoolarships, :moduser_id, :registered_by_id
    else
      add_column :schoolarships, :registered_by_id, :integer
    end

    add_column :schoolarships, :modified_by_id, :integer
  end

  def self.down
    rename_column :schoolarships, :registered_by_id, :moduser_id
    remove_column :schoolarships, :modified_by_id
  end
end
