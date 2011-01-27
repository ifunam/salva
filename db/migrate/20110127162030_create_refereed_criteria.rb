class CreateRefereedCriteria < ActiveRecord::Migration
  def self.up
    create_table :refereed_criteria do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :refereed_criteria
  end
end
