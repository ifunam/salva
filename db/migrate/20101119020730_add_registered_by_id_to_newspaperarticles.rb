class AddRegisteredByIdToNewspaperarticles < ActiveRecord::Migration
  def self.up
    rename_column :newspaperarticles, :moduser_id, :registered_by_id
    add_column :newspaperarticles, :modified_by_id, :integer
  end

  def self.down
    rename_column :newspaperarticles, :registered_by_id, :moduser_id
    remove_column :newspaperarticles, :modified_by_id
  end
end
