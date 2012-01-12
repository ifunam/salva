class RenameSchoolingsToEducations < ActiveRecord::Migration
  def self.up
    if table_exists? :educations
      drop_table :educations
    end
    rename_table :schoolings, :educations
  end

  def self.down
    rename_table :educations, :schoolings
  end
end
