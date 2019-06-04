class AddShortNameToLabOrGroups < ActiveRecord::Migration
  def change
    add_column :lab_or_groups, :short_name, :text
  end
end
