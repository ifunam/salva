class AddRegisteredByToInproceedings < ActiveRecord::Migration
  def self.up
    if column_exists?  :inproceedings, :moduser_id
      rename_column :inproceedings, :moduser_id, :registered_by_id
    else
      add_column :inproceedings, :registered_by_id, :integer
    end
    add_column :inproceedings, :modified_by_id, :integer
  end

  def self.down
    rename_column :inproceedings, :registered_by_id, :moduser_id
    remove_column :inproceedings, :modified_by_id
  end
end
