class RenameModuserIdToModifiedByIdInUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :moduser_id, :modified_by_id
  end

  def self.down
    rename_column :users, :modified_by_id, :moduser_id
  end
end
