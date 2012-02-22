class RenameUserStimulusesToUserStimuli < ActiveRecord::Migration
  
  def self.up
      if table_exists? :user_stimuluses    
        rename_table :user_stimuluses, :user_stimuli      
      elsif table_exists? :user_stimulus
        rename_table :user_stimulus, :user_stimuli
      end
  end

  def self.down
      rename_table :user_stimuli, :user_stimuluses
  end
end
