class AddRegisteredByToAcadvisits < ActiveRecord::Migration
  def change
    if column_exists? :acadvisits, :moduser_id
      rename_column :acadvisits, :moduser_id, :registered_by_id
    else
      add_column :acadvisits, :registered_by_id, :integer
    end
    add_column :acadvisits, :modified_by_id, :integer
  end
end
