class AddLockableToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :failed_attempts, :integer, default: 0
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime
    # t.lockable :lock_strategy => Devise.lock_strategy, :unlock_strategy => Devise.unlock_strategy
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
