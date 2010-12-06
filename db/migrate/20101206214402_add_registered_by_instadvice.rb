class AddRegisteredByInstadvice < ActiveRecord::Migration
  def self.up
    if column_exists? :instadvices, :moduser_id
      rename_column :instadvices, :moduser_id, :registered_by_id
    else
      add_column :instadvices, :registered_by_id, :integer
    end

    add_column :instadvices, :modified_by_id, :integer
  end

  def self.down
    rename_column :instadvices, :registered_by_id, :moduser_id
    remove_column :instadvices, :modified_by_id
  end
end
