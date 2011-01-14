class AddRegisteredByToPrizes < ActiveRecord::Migration
  def self.up
    rename_column :prizes, :moduser_id, :registered_by_id
    add_column    :prizes, :modified_by_id, :integer
  end

  def self.down
    rename_column :prizes, :registered_by_id, :moduser_id
    remove_column :prizes, :modified_by_id
  end
end
