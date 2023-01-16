class Career < ActiveRecord::Base
  validates_presence_of :name, :degree_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :degree_id, :greater_than => 0, :only_integer => true

  belongs_to :degree
  belongs_to :institution, :class_name => 'Institution', :foreign_key => 'institution_id'
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  belongs_to :university, :class_name => 'Institution', :foreign_key => 'university_id'
  belongs_to :country, :class_name => 'Country', :foreign_key => 'country_id'

  has_many :indivadvices
  has_many :educations
  has_many :tutorial_committees
  has_many :theses
  has_many :academicprograms
  has_many :institutioncareers
  # attr_accessor :name, :degree_id, :institution_attributes, :abbrev, :institution_id, :university_id, :country_id

  def to_s
    grado = degree.nil? ? nil : degree.name
    escuela = institution.nil? ? nil : institution.name
    universidad = university.nil? ? nil : university.name
    pais = country.nil? ? nil : country.name
    ["Carrera: #{name}, Grado: #{grado}",escuela,universidad,pais].join(', ')
  end
end
