class AddRegisteredByIdToReviews < ActiveRecord::Migration
  def self.up
    rename_column :reviews, :moduser_id, :registered_by_id
    add_column :reviews, :modified_by_id, :integer
  end

  def self.down
    rename_column :reviews, :registered_by_id, :moduser_id
    remove_column :reviews, :modified_by_id
  end
end
