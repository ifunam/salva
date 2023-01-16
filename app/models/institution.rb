# encoding: utf-8
class Institution < ActiveRecord::Base
  # attr_accessor :name, :abbrev, :institution_id, :institutiontype_id, :institutiontitle_id, :country_id
  validates_presence_of :name, :institutiontitle_id, :institutiontype_id, :country_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institutiontitle_id, :institutiontype_id, :country_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :state_id, :city_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :institutiontype
  belongs_to :institutiontitle, :inverse_of => :institutions
  belongs_to :institution
  belongs_to :country
  belongs_to :city
  belongs_to :state
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :acadvisits
  has_many :adscriptions
  has_many :careers
  has_many :conference_institutions
  has_many :courses
  has_many :genericworks
  has_many :indivadvices
  has_many :indivadviceprograms
  has_many :instadvices
  has_many :institutions
  has_many :institutional_activities
  has_many :institutioncareers
  has_many :jobpositions
  has_many :memberships
  has_many :prizes
  has_many :projectfinancingsources
  has_many :projectinstitutions
  has_many :schoolarships
  has_many :seminaries
  has_many :sponsor_acadvisits
  has_many :stimulustypes
  has_many :techproducts
  has_many :user_languages

  default_scope -> { order(id: :asc) }
  # UNAM, DGAPA, CONACYT, and your institution
  scope :for_schoolarships, -> { where("id = 1 OR id = 96 OR id = 5453 OR administrative_key = '314'") }
  scope :for_conferences, -> { where("id = 1 OR id = 96 OR id = 5453 OR administrative_key = '314'") }
  scope :for_categories, -> { where("institution_id = 1") }
  scope :for_universities, -> { where("institutions.name ILIKE '%niversi%' or institutions.name ILIKE '%INVESTAV%' or institutions.name ILIKE '%NIVERSI%' or institutions.name ILIKE '%investav%' or institutions.name ILIKE '%nstitut polit%' or institutions.name ILIKE '%nstitut Polit%' or institutions.name ILIKE '%acional%' or institutions.name ILIKE '%nvestigaci%' ") }
  scope :for_faculties, -> { where("institutions.name NOT ILIKE '%niversi%' AND (institutions.name ILIKE '%acult%' OR institutions.name ILIKE '%scuela%' OR institutions.name ILIKE '%chool%' OR institutions.name ILIKE '%cole%' OR institutions.name ILIKE '%chule%' OR institutions.name ILIKE '%nstitut%' OR institutions.name ILIKE '%osgrad%' OR institutions.name ILIKE '%osgrad%' OR institutions.name ILIKE '%epartament%' OR institutions.name ILIKE '%epartment%' OR institutions.name ILIKE '%nidad%' OR institutions.name ILIKE '%cadémica%' OR institutions.name ILIKE '%ivisión%' OR institutions.name ILIKE '%ateria%')") }

  def to_s
    [name, abbrev].compact.join(', ').sub(/\s$/,'').sub(/\,$/,'').sub(/\.$/,'')
  end

  def name_and_parent_abbrev
    name_and_parent(:abbrev)
  end

  def name_and_parent_name
    name_and_parent(:name)
  end

  def school_and_university_names
    names = ["Facultad, escuela o posgrado: #{name}"]
    names.push("Institución: #{institution.name}") unless institution_id.nil?
    names.join(', ')
  end

  def name_and_parent(attribute=:abbrev)
     unless institution.nil?
       [to_s, institution.send(attribute)].compact.join(', ')
     else
        to_s
     end
  end

  def parent_name
    institution_id.nil? ? "-" : institution.name
  end

  def name_and_country
    !country.nil? ? [name, country.name].join(', ') : name
  end

  def country_name
    country_id.nil? ? '-' : country.name
  end
end
