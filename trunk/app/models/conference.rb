class Conference < ActiveRecord::Base
  validates_presence_of :name, :year, :conferencetype_id, :country_id
  validates_numericality_of :conferencetype_id, :country_id

  belongs_to :conferencetype
  belongs_to :country
  belongs_to :conferencescope
 
  has_many :conference_institution
  attr_accessor :institution_id
end
