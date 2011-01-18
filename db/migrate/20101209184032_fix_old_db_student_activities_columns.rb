class FixOldDbStudentActivitiesColumns < ActiveRecord::Migration
  def self.up
    unless column_exists? :student_activities, :tutor_externaluser_id
      add_column :student_activities, :tutor_externaluser_id, :integer
      execute "ALTER TABLE student_activities ADD CONSTRAINT student_activities_check CHECK ((((tutor_is_internal = true) AND (tutor_user_id IS NOT NULL)) AND (tutor_externaluser_id IS NULL)));"
      execute "ALTER TABLE student_activities ADD CONSTRAINT student_activities_check1 CHECK ((((tutor_is_internal = false) AND (tutor_user_id IS NULL)) AND (tutor_externaluser_id IS NOT NULL)));"
    end
  end

  def self.down
  end
end
