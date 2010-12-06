class AddRegisteredByToTechproducttype < ActiveRecord::Migration
  def self.up
    if column_exists? :techproducttypes, :moduser_id
     rename_column :techproducttypes, :moduser_id, :registered_by_id
    else
      add_column :techproducttypes, :registered_by_id, :integer
    end
    add_column :techproducttypes, :modified_by_id, :integer
  end

  def self.down
    rename_column :techproducttypes, :registered_by_id, :moduser_id
    remove_column :techproducttypes, :modified_by_id
  end
end
