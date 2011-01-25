class AddCareerIdToAcademicprograms < ActiveRecord::Migration
  def self.up
    add_column :academicprograms, :career_id, :integer
  end

  def self.down
    remove_column :academicprograms, :career_id
  end
end
