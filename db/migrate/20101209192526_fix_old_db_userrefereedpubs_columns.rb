class FixOldDbUserrefereedpubsColumns < ActiveRecord::Migration
  def self.up
    unless column_exists? :userrefereedpubs, :externaluser_id
      add_column :userrefereedpubs, :externaluser_id, :integer
    end

    unless column_exists? :userrefereedpubs, :internaluser_id
      add_column :userrefereedpubs, :internaluser_id, :integer
    end

    if column_exists? :userrefereedpubs, :user_id
      remove_column :userrefereedpubs, :user_id
    end

#    execute "ALTER TABLE userrefereedpubs ADD CONSTRAINT userrefereedpubs_check CHECK (((user_is_internal = true) OR ((internaluser_id IS NOT NULL) AND (externaluser_id IS NULL))));"
#    execute "ALTER TABLE userrefereedpubs ADD CONSTRAINT userrefereedpubs_check1 CHECK (((user_is_internal = false) OR ((externaluser_id IS NOT NULL) AND (internaluser_id IS NULL))));"
  end

  def self.down
  end
end
