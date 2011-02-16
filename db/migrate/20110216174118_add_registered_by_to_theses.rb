class AddRegisteredByToTheses < ActiveRecord::Migration
  def self.up
    if column_exists?  :theses, :moduser_id
      rename_column :theses, :moduser_id, :registered_by_id
    else
      add_column :theses, :registered_by_id, :integer
    end

    add_column :theses, :modified_by_id, :integer
  end

  def self.down
    rename_column :theses, :registered_by_id, :moduser_id
    remove_column :theses, :modified_by_id
  end
end
