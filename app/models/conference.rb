class Conference < ActiveRecord::Base
  attr_accessor :roleinconference_id
  validates_presence_of :name, :year, :conferencetype_id, :country_id

  validates_numericality_of :id, :conferencescope_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :conferencetype_id, :country_id,  :greater_than =>0, :only_integer => true

  validates_inclusion_of :isspecialized, :in=> [true, false]

  named_scope :local_scope, :conditions => 'conferencescope_id = 1'
  named_scope :national_scope, :conditions => 'conferencescope_id = 2'
  named_scope :international_scope, :conditions => 'conferencescope_id = 3'
  
  belongs_to :conferencetype
  belongs_to :country
  belongs_to :conferencescope

  has_many :conference_institutions
  has_many :institutions, :through => :conference_institutions
end
