class AddCareerIdToEducations < ActiveRecord::Migration
  def self.up
    add_column :educations, :career_id, :integer
  end

  def self.down
    remove_column :educations, :career_id
  end
end
