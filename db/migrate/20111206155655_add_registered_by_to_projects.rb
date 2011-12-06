class AddRegisteredByToProjects < ActiveRecord::Migration
  def change
    if column_exists?  :projects, :moduser_id
      rename_column :projects, :moduser_id, :registered_by_id
    else
      add_column :projects, :registered_by_id, :integer
    end
    add_column :projects, :modified_by_id, :integer
  end
end
