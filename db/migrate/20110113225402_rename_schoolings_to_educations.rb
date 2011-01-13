class RenameSchoolingsToEducations < ActiveRecord::Migration
  def self.up
    rename_table :schoolings, :educations
  end

  def self.down
    rename_table :educations, :schoolings
  end
end
