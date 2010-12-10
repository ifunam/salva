class AddApprovedByToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :approved_by_id, :integer
    add_column :documents, :approved, :boolean, :default => false
  end

  def self.down
    remove_column :documents, :approved_by_id
    remove_column :documents, :approved
  end
end
