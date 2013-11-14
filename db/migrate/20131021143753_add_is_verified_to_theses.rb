class AddIsVerifiedToTheses < ActiveRecord::Migration
  def change
    add_column :theses, :is_verified, :boolean
  end
end
