class AddIsVerifiedToJournals < ActiveRecord::Migration
  def change
    add_column :journals, :is_verified, :boolean
  end
end
