class AddCareerIdToTheses < ActiveRecord::Migration
  def self.up
    add_column :theses, :career_id, :integer
  end

  def self.down
    remove_column :theses, :career_id
  end
end
