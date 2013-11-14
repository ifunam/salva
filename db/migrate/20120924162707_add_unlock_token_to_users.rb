class AddUnlockTokenToUsers < ActiveRecord::Migration
  def change
    unless column_exists? :users, :unlock_token
      add_column :users, :unlock_token, :string
    end
  end
end
