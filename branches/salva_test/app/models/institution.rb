class Institution < ActiveRecord::Base
  validates_presence_of :name, :institutiontitle_id, :institutiontype_id, :country_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institutiontitle_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institutiontype_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :country_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :country
  belongs_to :institutiontype
  belongs_to :institutiontitle
  belongs_to :city
  belongs_to :state
  belongs_to :institution

  validates_associated :institution, :on => :update
  validates_associated :institutiontitle, :on => :update
  validates_associated :institutiontype, :on => :update
  validates_associated :country, :on => :update
  validates_associated :state, :on => :update
  validates_associated :city, :on => :update

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

  def as_text
    values = [name, abbrev]
    values << institution.name unless institution.name.nil?
    values.compact.join(', ')
  end
end
