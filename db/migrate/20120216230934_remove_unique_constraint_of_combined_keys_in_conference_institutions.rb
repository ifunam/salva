class RemoveUniqueConstraintOfCombinedKeysInConferenceInstitutions < ActiveRecord::Migration
  def up
    execute "ALTER TABLE conference_institutions DROP CONSTRAINT conference_institutions_conference_id_key"
  end

  def down
    execute "ALTER TABLE conference_institutions ADD CONSTRAINT conference_institutions_conference_id_key UNIQUE (conference_id, institution_id)"
  end
end
