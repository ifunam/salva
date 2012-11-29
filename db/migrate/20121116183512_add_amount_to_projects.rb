class AddAmountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :amount, :decimal, :default => 0
  end
end
