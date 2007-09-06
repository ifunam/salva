class Conference < ActiveRecord::Base
  validates_presence_of :name, :year, :conferencetype_id, :country_id
  validates_numericality_of :conferencetype_id, :country_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_uniqueness_of :id, :name
  belongs_to :conferencetype
  belongs_to :country
  belongs_to :conferencescope

  has_many :conference_institutions
  has_many :institutions, :through => :conference_institutions
  has_many :proceedings
  has_many :userconferences
end
