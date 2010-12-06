class AddRegisteredByToTechproducts < ActiveRecord::Migration
  def self.up
    if column_exists? :techproducts, :moduser_id
     rename_column :techproducts, :moduser_id, :registered_by_id
    else
      add_column :techproducts, :registered_by_id, :integer
    end
    add_column :techproducts, :modified_by_id, :integer
  end

  def self.down
    rename_column :techproducts, :registered_by_id, :moduser_id
  remove_column :techproducts, :modified_by_id
  end
end
