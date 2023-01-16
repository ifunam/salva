# encoding: utf-8
class Academicprogram < ActiveRecord::Base
  # attr_accessor :academicprogramtype_id, :year, :career_attributes, :institution_id, :university_id, :country_id, :career_id, :degree_id
  validates_presence_of :academicprogramtype_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :academicprogramtype_id, :year,  :greater_than => 0, :only_integer => true

  belongs_to :career, :class_name => 'Career', :foreign_key => 'career_id'
  belongs_to :degree, :class_name => 'Degree', :foreign_key => 'degree_id'
  belongs_to :institution, :class_name => 'Institution', :foreign_key => 'institution_id'
  belongs_to :university, :class_name => 'Institution', :foreign_key => 'university_id'
  belongs_to :country, :class_name => 'Country', :foreign_key => 'country_id'

  #belongs_to :institutioncareer # FIX IT: Remove this relationship until next release.
                                # We need institutioncareers table to support
                                # migrations from previous versions of salva databases.
  belongs_to :career
  accepts_nested_attributes_for :career
  belongs_to :academicprogramtype

  has_many :regularcourses

  def to_s
    ["Tipo de programa académico: #{academicprogramtype.name}", "Año del programa: #{year}"].join(', ')
  end

  def to_s_with_career
    @career = career.nil? ? nil.to_s : career.name
    @degree = degree.nil? ? nil.to_s : degree.name
    @institution = institution.nil? ? nil.to_s : institution.name
    @university = university.nil? ? nil.to_s : university.name
    ["Carrera: #{@career}, Grado: #{@degree}",@institution,@university,to_s].join(', ')
  end

end
