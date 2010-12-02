class AddRegisteredByToUsers < ActiveRecord::Migration
  def self.up
    unless column_exists? :users, :registered_by_id
      add_column :users, :registered_by_id, :integer
    end
  end

  def self.down
    remove_column :users, :registered_by_id
  end
end
