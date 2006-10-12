class ConferenceInstitution  < ModelComposedKeys
  set_table_name "conference_institutions"
  set_primary_keys :conference_id

  validates_presence_of :conference_id, :institution_id
  validates_numericality_of :conference_id, :institution_id
  belongs_to :conference
  belongs_to :institution
end
