class AddInstructorsToSeminaries < ActiveRecord::Migration
  def self.up
    add_column :seminaries, :instructors, :string
  end

  def self.down
    remove_column :seminaries, :instructors
  end
end
