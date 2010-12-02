class AddRegisteredByToCredittypes < ActiveRecord::Migration
  def self.up
    if column_exists?  :credittypes, :moduser_id
      rename_column :credittypes, :moduser_id, :registered_by_id
    else
      add_column :credittypes, :registered_by_id, :integer
    end

    add_column :credittypes, :modified_by_id, :integer
  end

  def self.down
    rename_column :credittypes, :registered_by_id, :moduser_id
    remove_column :credittypes, :modified_by_id
  end
end
