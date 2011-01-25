class RemoveNotNullConstraintForInstitutionCareerIdInAcademicprograms < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE academicprograms ALTER COLUMN institutioncareer_id DROP NOT NULL"
  end

  def self.down
    execute "ALTER TABLE academicprograms ALTER COLUMN institutioncareer_id SET NOT NULL"
  end
end
