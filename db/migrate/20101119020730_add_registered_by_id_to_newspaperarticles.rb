class AddRegisteredByIdToNewspaperarticles < ActiveRecord::Migration
  def self.up
    if column_exists?  :newspaperarticles, :moduser_id
      rename_column :newspaperarticles, :moduser_id, :registered_by_id
    else
      add_column :newspaperarticles, :registered_by_id, :integer
    end

    add_column :newspaperarticles, :modified_by_id, :integer
  end

  def self.down
    rename_column :newspaperarticles, :registered_by_id, :moduser_id
    remove_column :newspaperarticles, :modified_by_id
  end
end
