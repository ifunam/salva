class FixOldDbUserSkillsColumns < ActiveRecord::Migration
  def self.up
    unless column_exists? :user_skills, :descr_en
      add_column :user_skills, :descr_en, :text
    end
  end

  def self.down
  end
end
