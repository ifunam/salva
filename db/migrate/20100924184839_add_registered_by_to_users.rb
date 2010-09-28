class AddRegisteredByToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :registered_by_id, :integer
  end

  def self.down
    remove_column :users, :registered_by_id
  end
end
