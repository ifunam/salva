class RemoveUserStimulus < ActiveRecord::Migration
  def self.up
    if table_exists? :user_stimulus
      drop_table :user_stimulus
    end
  end

  def self.down
    create_table :user_stimulus, :force => true do |t|
      t.references :user, :stimuluslevel, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.timestamps
    end
  end

end
