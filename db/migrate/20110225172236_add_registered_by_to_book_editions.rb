class AddRegisteredByToBookEditions < ActiveRecord::Migration
   def self.up
    if column_exists?  :bookeditions, :moduser_id
      rename_column :bookeditions, :moduser_id, :registered_by_id
    else
      add_column :bookeditions, :registered_by_id, :integer
    end

    add_column :bookeditions, :modified_by_id, :integer
  end

  def self.down
    rename_column :bookeditions, :registered_by_id, :moduser_id
    remove_column :bookeditions, :modified_by_id
  end
end
