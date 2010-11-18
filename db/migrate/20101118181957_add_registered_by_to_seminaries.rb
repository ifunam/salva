class AddRegisteredByToSeminaries < ActiveRecord::Migration
  def self.up
    rename_column :seminaries, :moduser_id, :registered_by_id
    add_column :seminaries, :modified_by_id, :integer
  end

  def self.down
    rename_column :seminaries, :registered_by_id, :moduser_id
    remove_column :seminaries, :modified_by_id
  end
end
