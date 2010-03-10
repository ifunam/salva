class RenameInternaluserToUser < ActiveRecord::Migration
  def self.up
    rename_column :usercredits, :internalusergive_id, :usergive_id
    remove_column :usercredits, :usergive_is_internal
    
    rename_column :userrefereedpubs, :internaluser_id, :user_id
    rename_column :userresearchgroups, :internaluser_id, :user_id
    
  end

  def self.down
    rename_column :usercredits, :usergive_id, :internalusergive_id
    add_column :usercredits, :usergive_is_internal, :boolean
    
    rename_column :userrefereedpubs, :user_id, :internaluser_id  
    rename_column :userresearchgroups, :user_id, :internaluser_id
  end
end
