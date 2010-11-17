class AddRegisteredByToLanguages < ActiveRecord::Migration
  def self.up
    rename_column :languages, :moduser_id, :registered_by_id
    add_column :languages, :modified_by_id, :integer
  end

  def self.down
    rename_column :languages, :registered_by_id, :moduser_id
    remove_column :languages, :modified_by_id
  end
end
