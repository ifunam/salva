class AddSchoolarshipIdToJobpositions < ActiveRecord::Migration
  def self.up
    add_column :jobpositions, :schoolard_id, :integer
  end

  def self.down
    remove_column :jobpositions, :schoolard_id
  end
end
