class AddRegisteredByToSeminaries < ActiveRecord::Migration
  def self.up
    if column_exists?  :seminaries, :moduser_id
      rename_column :seminaries, :moduser_id, :registered_by_id
    else
      add_column :seminaries, :registered_by_id, :integer
    end

    add_column :seminaries, :modified_by_id, :integer
  end

  def self.down
    rename_column :seminaries, :registered_by_id, :moduser_id
    remove_column :seminaries, :modified_by_id
  end
end
