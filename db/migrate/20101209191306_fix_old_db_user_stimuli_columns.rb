# encoding: utf-8
class FixOldDbUserStimuliColumns < ActiveRecord::Migration
  def self.up
    if column_exists? :user_stimuli, :moduser_id
      remove_column :user_stimuli, :moduser_id
    end
    if column_exists? :user_stimuli, :created_at
      remove_column :user_stimuli, :created_at
    end
    if column_exists? :user_stimuli, :updated_at
      remove_column :user_stimuli, :updated_at
    end

    pg_result = execute("SELECT conname FROM pg_constraint WHERE conname = 'user_stimulus_endmonth_check'")
    if pg_result.ntuples == 0
      execute "ALTER TABLE user_stimuli ADD CONSTRAINT user_stimulus_endmonth_check CHECK (((endmonth <= 12) AND (endmonth >= 1)))"
    end

    pg_result = execute("SELECT conname FROM pg_constraint WHERE conname = 'user_stimulus_startmonth_check'")
    if pg_result.ntuples == 0
      execute "ALTER TABLE user_stimuli ADD CONSTRAINT user_stimulus_startmonth_check CHECK (((startmonth <= 12) AND (startmonth >= 1)))"
    end

    execute "COMMENT ON TABLE user_stimuli IS 'Estímulos con que ha contado un usuario, incluyendo nivel, con fecha de inicio/término'"
  end

  def self.down
  end
end
