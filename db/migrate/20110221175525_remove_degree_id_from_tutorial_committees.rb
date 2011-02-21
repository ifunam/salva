class RemoveDegreeIdFromTutorialCommittees < ActiveRecord::Migration
  def self.up
    remove_column :tutorial_committees, :degree_id
  end

  def self.down
    add_column :tutorial_committees, :degree_id, :integer
  end
end
