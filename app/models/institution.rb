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

  validates_associated :institutiontitle
  validates_associated :institutiontype
  # validates_associated :institution, avoid recursion bugs..
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

  index 'for_autocomplete', 'pg_catalog.spanish' do
    name
  end

  def as_text
    values = [name, abbrev]
    values << institution.name unless institution.name.nil?
    values.compact.join(', ')
  end
end
