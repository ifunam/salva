class Institution < ActiveRecord::Base
  validates_presence_of :name, :institutiontitle_id, :institutiontype_id, :country_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institutiontitle_id, :institutiontype_id, :country_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :state_id, :city_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :institutiontype
  belongs_to :institutiontitle
  belongs_to :institution
  belongs_to :country
  belongs_to :city
  belongs_to :state
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  validates_associated :institutiontitle
  validates_associated :institutiontype
  validates_associated :country
  validates_associated :state
  validates_associated :city

  has_many :prizes
  has_many :grants
  has_many :acadvisits
  has_many :courses
  has_many :schoolarships
  has_many :memberships
  has_many :projectfinancingsources
  has_many :jobpositions
  has_many :projectinstitutions
  has_many :instadvices
  has_many :institutional_activities
  has_many :conference_institutions
  has_many :genericworks
  has_many :institutioncareers

  default_scope :order => 'name ASC'
  # UNAM, DGAPA, CONACYT, and your institution
  scope :schoolarships, where("id = 1 OR id = 96 OR id = 5453 OR administrative_key = '314'")
  
  def as_text
    [name, abbrev].compact.join(', ').sub(/\s$/,'').sub(/\,$/,'').sub(/\.$/,'')
  end

  def name_and_parent_abbrev
     unless institution.nil?
       [as_text, institution.abbrev].compact.join(' - ')
     else
        as_text
     end
  end
end
