class AddRegisteredByToCities < ActiveRecord::Migration
  def change
   if column_exists?  :cities, :moduser_id
      rename_column :cities, :moduser_id, :registered_by_id
    else
      add_column :cities, :registered_by_id, :integer
    end
    add_column :cities, :modified_by_id, :integer    
  end
end
