class AddRegisteredByToBookeditionRoleinbooks < ActiveRecord::Migration
  def self.up
    if column_exists?  :bookedition_roleinbooks, :moduser_id
      rename_column :bookedition_roleinbooks, :moduser_id, :registered_by_id
    else
      add_column :bookedition_roleinbooks, :registered_by_id, :integer
    end

    add_column :bookedition_roleinbooks, :modified_by_id, :integer
  end

  def self.down
    rename_column :bookedition_roleinbooks, :registered_by_id, :moduser_id
    remove_column :bookedition_roleinbooks, :modified_by_id
  end

end
