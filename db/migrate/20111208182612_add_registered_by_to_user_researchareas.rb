class AddRegisteredByToUserResearchareas < ActiveRecord::Migration
  def change
    if column_exists?  :researchareas, :moduser_id
      rename_column :researchareas, :moduser_id, :registered_by_id
    else
      add_column :researchareas, :registered_by_id, :integer
    end
    add_column :researchareas, :modified_by_id, :integer
  end
end



