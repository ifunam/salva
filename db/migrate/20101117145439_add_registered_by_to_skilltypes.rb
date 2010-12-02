class AddRegisteredByToSkilltypes < ActiveRecord::Migration
  def self.up
    if column_exists? :skilltypes, :moduser_id
      rename_column :skilltypes, :moduser_id, :registered_by_id
    else
      add_column :skilltypes, :registered_by_id, :integer
    end

    add_column :skilltypes, :modified_by_id, :integer
  end

  def self.down
    rename_column :skilltypes, :registered_by_id, :moduser_id
    remove_column :skilltypes, :modified_by_id
  end
end
