class AddCareerIdToTutorialCommittees < ActiveRecord::Migration
  def self.up
    add_column :tutorial_committees, :career_id, :integer
  end

  def self.down
    remove_column :tutorial_committees, :career_id
  end
end
