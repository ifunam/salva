class AddRegisteredByToUserSkills < ActiveRecord::Migration
  def self.up
    if column_exists? :user_skills, :moduser_id
      rename_column :user_skills, :moduser_id, :registered_by_id
    else
      add_column :user_skills, :registered_by_id, :integer
    end

    add_column :user_skills, :modified_by_id, :integer
  end

  def self.down
    rename_column :user_skills, :registered_by_id, :moduser_id
    remove_column :user_skills, :modified_by_id
  end
end
