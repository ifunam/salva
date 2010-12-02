class StandarizePeople < ActiveRecord::Migration
  def self.up
      add_column :people, :id, :serial;
  end
  def self.down
    remove_column :people, :id
  end
end
