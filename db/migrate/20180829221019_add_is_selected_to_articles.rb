class AddIsSelectedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_selected, :boolean, :default => false
  end
end
