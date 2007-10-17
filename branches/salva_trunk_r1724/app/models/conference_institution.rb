class ConferenceInstitution  < ActiveRecord::Base
  validates_presence_of :conference_id, :institution_id
  validates_numericality_of :conference_id, :institution_id
  validates_uniqueness_of :conference_id, :scope => [:institution_id]
  belongs_to :conference
  belongs_to :institution
end
