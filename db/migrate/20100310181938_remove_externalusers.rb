class RemoveExternalusers < ActiveRecord::Migration
  def self.up
    
    remove_column :student_activities, :tutor_externaluser_id
    remove_column :usercredits, :externalusergive_id
    remove_column :userrefereedpubs, :externaluser_id
    remove_column :userresearchgroups, :externaluser_id
    remove_column :acadvisits, :externaluser_id
    
    drop_table :externaluserlevels
    drop_table :externalusers
  end

  def self.down
    create_table :externaluserlevels, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :externaluserlevels, [:name], :name => :externaluserlevels_name_key, :unique => true

    create_table :externalusers, :force => true do |t|
      t.references :institution, :externaluserlevel, :degree
      t.text :firstname, :lastname1, :null => false
      t.text :lastname2
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
  
     add_column :student_activities, :tutor_externaluser_id, :integer
     add_index :student_activities, [:tutor_user_id, :user_id], :name => :student_activities_user_id_key, :unique => true
     add_index :student_activities, [:tutor_externaluser_id, :user_id], :name => :student_activities_user_id_key1, :unique => true

     add_column :usercredits, :externalusergive_id, :integer     
     add_index :userrefereedpubs, [:externaluser_id, :internaluser_id, :refereedpubs_id], :name => :userrefereedpubs_refereedpubs_id_key, :unique => true

     add_column :usercredits, :externaluser_id, :integer
     add_index :userresearchgroups, [:externaluser_id, :researchgroup_id], :name => :userresearchgroups_researchgroup_id_key1, :unique => true
   end
end
