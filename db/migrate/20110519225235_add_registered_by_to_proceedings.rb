class AddRegisteredByToProceedings < ActiveRecord::Migration
   def self.up
    if column_exists?  :proceedings, :moduser_id
      rename_column :proceedings, :moduser_id, :registered_by_id
    else
      add_column :proceedings, :registered_by_id, :integer
    end
    add_column :proceedings, :modified_by_id, :integer
  end

  def self.down
    rename_column :proceedings, :registered_by_id, :moduser_id
    remove_column :proceedings, :modified_by_id
  end
end
