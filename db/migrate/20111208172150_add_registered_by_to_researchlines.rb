class AddRegisteredByToResearchlines < ActiveRecord::Migration
  def change
    if column_exists?  :researchlines, :moduser_id
      rename_column :researchlines, :moduser_id, :registered_by_id
    else
      add_column :researchlines, :registered_by_id, :integer
    end
    add_column :researchlines, :modified_by_id, :integer
  end
end
