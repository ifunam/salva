class AddRegisteredByToRegularcourses < ActiveRecord::Migration
  def self.up
    if column_exists?  :regularcourses, :moduser_id
      rename_column :regularcourses, :moduser_id, :registered_by_id
    else
      add_column :regularcourses, :registered_by_id, :integer
    end

    add_column :regularcourses, :modified_by_id, :integer
  end

  def self.down
    rename_column :regularcourses, :registered_by_id, :moduser_id
    remove_column :regularcourses, :modified_by_id
  end
end
