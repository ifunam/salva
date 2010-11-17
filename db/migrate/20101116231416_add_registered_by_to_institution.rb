class AddRegisteredByToInstitution < ActiveRecord::Migration
  def self.up
    rename_column :institutions, :moduser_id, :registered_by_id
    add_column :institutions, :modified_by_id, :integer
  end

  def self.down
    rename_column :institutions, :registered_by_id, :moduser_id
    remove_column :institutions, :modified_by_id
  end
end
