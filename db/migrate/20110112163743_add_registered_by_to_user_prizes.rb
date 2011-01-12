class AddRegisteredByToUserPrizes < ActiveRecord::Migration
  def self.up
    rename_column :user_prizes, :moduser_id, :registered_by_id
    add_column    :user_prizes, :updated_by_id, :integer
  end

  def self.down
    rename_column :user_prizes, :registered_by_id, :moduser_id
    remove_column :user_prizes, :updated_by_id
  end
end
