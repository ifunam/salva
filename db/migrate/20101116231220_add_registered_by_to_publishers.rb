class AddRegisteredByToPublishers < ActiveRecord::Migration
  def self.up
    if column_exists? :publishers, :moduser_id
      rename_column :publishers, :moduser_id, :registered_by_id
    else
      add_column :publishers, :registered_by_id, :integer
    end

    add_column :publishers, :modified_by_id, :integer
  end

  def self.down
    rename_column :publishers, :registered_by_id, :moduser_id
    remove_column :publishers, :modified_by_id
  end
end
