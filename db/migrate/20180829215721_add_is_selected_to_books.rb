class AddIsSelectedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :is_selected, :boolean, :default => false
  end
end
