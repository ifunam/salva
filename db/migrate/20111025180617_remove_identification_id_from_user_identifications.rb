class RemoveIdentificationIdFromUserIdentifications < ActiveRecord::Migration
  def self.up
    remove_column :user_identifications, :identification_id
  end

  def self.down
    add_column :user_identifications, :identification_id, :integer
  end
end
