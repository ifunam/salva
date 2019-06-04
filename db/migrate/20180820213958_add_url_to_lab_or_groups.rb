class AddUrlToLabOrGroups < ActiveRecord::Migration
  def change
    add_column :lab_or_groups, :url, :text
  end
end
