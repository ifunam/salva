class ConferenceInstitution  < ActiveRecord::Base
  validates_presence_of :conference_id, :institution_id

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :conference_id, :institution_id, :greater_than =>0, :only_integer => true

  validates_uniqueness_of :conference_id, :scope => [:institution_id]

  belongs_to :conference
  belongs_to :institution

  validates_associated :conference
  validates_associated :institution

end
