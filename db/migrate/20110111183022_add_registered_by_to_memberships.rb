class AddRegisteredByToMemberships < ActiveRecord::Migration
  def self.up
    rename_column :memberships, :moduser_id, :registered_by_id
    add_column    :memberships, :created_by_id, :integer
  end

  def self.down
    rename_column :memberships, :registered_by_id, :moduser_id
    remove_column :memberships, :created_by_id
  end
end
