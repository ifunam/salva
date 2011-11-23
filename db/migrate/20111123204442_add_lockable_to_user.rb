class AddLockableToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.lockable :lock_strategy => Devise.lock_strategy, :unlock_strategy => Devise.unlock_strategy
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
