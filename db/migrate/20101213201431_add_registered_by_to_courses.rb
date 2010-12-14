class AddRegisteredByToCourses < ActiveRecord::Migration
  def self.up
    if column_exists? :courses, :moduser_id
      rename_column :courses, :moduser_id, :registered_by_id
    else
      add_column :courses, :registered_by_id, :integer
    end

    add_column :courses, :modified_by_id, :integer
  end

  def self.down
    rename_column :courses, :registered_by_id, :moduser_id
    remove_column :courses, :modified_by_id
  end
end
