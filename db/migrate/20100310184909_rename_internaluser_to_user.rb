class RenameInternaluserToUser < ActiveRecord::Migration
  def self.up
    if table_exists? :usercredits
      rename_column :usercredits, :internalusergive_id, :usergive_id
      remove_column :usercredits, :usergive_is_internal
    else
      create_table :usercredits do |t|
        t.integer :internalusergive_id, :externalusergive_id, :month
        t.integer :year, :null => false
        t.boolean :usergive_is_internal
        t.text :other
      end
    end
    
    if table_exists? :userrefereedpubs 
      if column_exists?(:userrefereedpubs, :internaluser_id)
        rename_column :userrefereedpubs, :internaluser_id, :user_id
      else
        create_table :userrefereedpubs do |t|
          t.integer :refereedpubs_id, :null => false
          t.boolean :user_is_internal
          t.integer :externaluser_id
          t.integer :internaluser_id
        end
      end
    end
    if table_exists? :userresearchgroups
      if column_exists? :userresearchgroups, :internaluser_id
        rename_column :userresearchgroups, :internaluser_id, :user_id
      else
        create_table :userresearchgroups do |t|
          t.integer :researchgroup_id, null => false
          t.integer :year, null => false
          t.boolean :user_is_internal
          t.integer :externaluser_id, :internaluser_id, :moduser_id
        end
      end
    end
  end

  def self.down
    rename_column :usercredits, :usergive_id, :internalusergive_id
    add_column :usercredits, :usergive_is_internal, :boolean
    
    rename_column :userrefereedpubs, :user_id, :internaluser_id  
    rename_column :userresearchgroups, :user_id, :internaluser_id
  end
end
