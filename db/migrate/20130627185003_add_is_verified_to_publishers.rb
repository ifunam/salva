class AddIsVerifiedToPublishers < ActiveRecord::Migration
  def change
    add_column :publishers, :is_verified, :boolean
  end
end
