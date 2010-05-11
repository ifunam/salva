class RemovingUserIdConstraintInUserAdscription < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE user_adscriptions ALTER COLUMN user_id DROP NOT NULL;"
  end

  def self.down
    execute "ALTER TABLE user_adscriptions ALTER COLUMN user_id SET NOT NULL;"
  end
end
