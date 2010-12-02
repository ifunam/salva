class MigrateUserStimulusToUserStimuli < ActiveRecord::Migration
  def self.up
    if table_exists? :user_stimulus
      execute 'INSERT INTO user_stimuli SELECT *,1 AS moduser_id FROM user_stimulus'
    end
  end

  def self.down
    unless table_exists? :user_stimulus
      create_table :user_stimulus, :force => true do |t|
        t.references :user, :stimuluslevel, :null => false
        t.integer :startyear, :null => false
        t.integer :startmonth, :endyear, :endmonth
        t.timestamps
      end
    end

    execute 'INSERT  INTO user_stimulus (user_id, stimuluslevel_id, startyear, startmonth, endyear, endmonth) SELECT user_id, stimuluslevel_id, startyear, startmonth, endyear, endmonth FROM user_stimuli'
  end
end




