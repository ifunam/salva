class RenameUserStimulusesToUserStimuli < ActiveRecord::Migration
  def self.up
      rename_table :user_stimuluses, :user_stimuli
  end

  def self.down
      rename_table :user_stimuli, :user_stimuluses
  end
end
