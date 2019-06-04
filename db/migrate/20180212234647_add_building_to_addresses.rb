class AddBuildingToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :building_id, :integer
  end
end
