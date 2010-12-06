class AddCareerToIndivadvices < ActiveRecord::Migration
  def self.up
    add_column :indivadvices, :career_id, :integer
  end

  def self.down
    remove_column :indivadvices, :career_id
  end
end
