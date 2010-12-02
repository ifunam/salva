class AddRegisteredByToUserLanguages < ActiveRecord::Migration
  def self.up
    if column_exists? :user_languages, :moduser_id
      rename_column :user_languages, :moduser_id, :registered_by_id
    else
      add_column :user_languages, :registered_by_id, :integer
    end

    add_column :user_languages, :modified_by_id, :integer
  end

  def self.down
    rename_column :user_languages, :registered_by_id, :moduser_id
    remove_column :user_languages, :modified_by_id
  end
end
