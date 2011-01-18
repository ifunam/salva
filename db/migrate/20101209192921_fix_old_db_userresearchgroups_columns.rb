class FixOldDbUserresearchgroupsColumns < ActiveRecord::Migration
  def self.up
    unless column_exists? :userresearchgroups, :externaluser_id
      add_column :userresearchgroups, :externaluser_id, :integer
    end

    unless column_exists? :userresearchgroups, :internaluser_id
      add_column :userresearchgroups, :internaluser_id, :integer
    end

    unless column_exists? :userresearchgroups, :moduser_id
      add_column :userresearchgroups, :moduser_id, :integer
    end

    if column_exists? :userresearchgroups, :user_id
      remove_column :userresearchgroups, :user_id
    end

#    execute "ALTER TABLE userresearchgroups ADD CONSTRAINT userresearchgroups_check CHECK (((user_is_internal = true) OR ((internaluser_id IS NOT NULL) AND (externaluser_id IS NULL))));"
#    execute "ALTER TABLE userresearchgroups ADD CONSTRAINT userresearchgroups_check1 CHECK (((user_is_internal = false) OR ((externaluser_id IS NOT NULL) AND (internaluser_id IS NULL))));"
  end

  def self.down
  end
end
