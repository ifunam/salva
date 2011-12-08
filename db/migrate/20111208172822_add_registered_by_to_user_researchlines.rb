class AddRegisteredByToUserResearchlines < ActiveRecord::Migration

  def change
    if column_exists?  :user_researchlines, :moduser_id
      rename_column :user_researchlines, :moduser_id, :registered_by_id
    else
      add_column :user_researchlines, :registered_by_id, :integer
    end
    add_column :user_researchlines, :modified_by_id, :integer
  end

end
