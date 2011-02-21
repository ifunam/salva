class RemoveNotNullConstraintForInstitutionCareerIdTutorialCommittees < ActiveRecord::Migration
 def self.up
    execute "ALTER TABLE tutorial_committees ALTER COLUMN institutioncareer_id DROP NOT NULL"
  end

  def self.down
    execute "ALTER TABLE tutorial_committees ALTER COLUMN institutioncareer_id SET NOT NULL"
  end
end
