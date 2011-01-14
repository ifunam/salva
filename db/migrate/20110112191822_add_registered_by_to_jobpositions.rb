class AddRegisteredByToJobpositions < ActiveRecord::Migration
  def self.up
    rename_column :jobpositions, :moduser_id, :registered_by_id
    add_column    :jobpositions, :modified_by_id, :integer
  end

  def self.down
    rename_column :jobpositions, :registered_by_id, :moduser_id
    remove_column :jobpositions, :modified_by_id
  end
end
