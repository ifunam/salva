class ConferenceInstitution  < ActiveRecord::Base
  # attr_accessor :institution_id, :conference_id
  validates_presence_of :institution_id
  validates_numericality_of :id, :conference_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :only_integer => true
  validates_uniqueness_of :conference_id, :scope => [:institution_id]

  belongs_to :conference
  belongs_to :institution
end
