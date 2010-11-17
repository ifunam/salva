class AddRegisteredByToUserSchoolarships < ActiveRecord::Migration
  def self.up
    add_column :user_schoolarships, :registered_by_id, :integer
    add_column :user_schoolarships, :modified_by_id, :integer
  end

  def self.down
    remove_column :user_schoolarships, :registered_by_id
    remove_column :user_schoolarships, :modified_by_id
  end
end
