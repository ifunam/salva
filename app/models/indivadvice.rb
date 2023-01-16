# encoding: utf-8
class Indivadvice < ActiveRecord::Base
  # attr_accessor :indivname, :institution_id, :startyear, :startmonth, :endyear, :endmonth,
                  #:hours, :indivadvicetarget_id, :career_attributes,
                  #:institution_id, :university_id, :country_id, :degree_id, :career_id

  validates_presence_of :indivadvicetarget_id, :indivname, :startyear, :hours
  validates_numericality_of :indivadvicetarget_id
  belongs_to :user
  belongs_to :indivuser, :class_name => "User", :foreign_key => "indivuser_id"


  belongs_to :indivadvicetarget
  belongs_to :indivadviceprogram
  belongs_to :institution

  # Fix It: Remove degree relationship in the next release
  #belongs_to :degree
  belongs_to :career # Used only for students
  belongs_to :career, :class_name => 'Career', :foreign_key => 'career_id'
  belongs_to :degree, :class_name => 'Degree', :foreign_key => 'degree_id'
  belongs_to :institution, :class_name => 'Institution', :foreign_key => 'institution_id'
  belongs_to :university, :class_name => 'Institution', :foreign_key => 'university_id'
  belongs_to :country, :class_name => 'Country', :foreign_key => 'country_id'
  accepts_nested_attributes_for :career

  belongs_to :registered_by, :class_name => "User"
  belongs_to :modified_by, :class_name => "User"

  default_scope -> { order(endyear: :desc, endmonth: :desc, startyear: :desc, startmonth: :desc, indivname: :asc) }
  scope :students, -> { where('indivadvicetarget_id <= 3') }
  scope :professors, -> { where('indivadvicetarget_id > 3') }
  scope :degree_id, lambda { |id| where("degree_id = ?", id) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :degree_id, :adscription_id

  def to_s
    if indivadvicetarget_id > 3
      [normalized_indivname,  institution_name, start_date, end_date, normalized_hours].compact.join(', ')
    else
      [normalized_indivname, indivadvicetarget.name, degree_name, career_name, institution_name, start_date, end_date, normalized_hours].compact.join(', ')
    end
  end

  def normalized_indivname
    prefix = indivadvicetarget_id > 3 ? 'Académico' : 'Estudiante'
    "#{prefix}: #{indivname}"
  end

  def degree_name
    "Grado: #{degree.name}" unless degree_id.nil?
  end

  def career_name
    "Carrera: #{career.name}" unless career_id.nil?
  end

  def institution_name
    escuela = institution.nil? ? nil : institution.name
    universidad = university.nil? ? nil : university.name
    "Facultad, escuela o posgrado: #{escuela}, Institución: #{universidad}"
  end

  def normalized_hours
    "Número de horas: #{hours}" unless hours.nil?
  end
end
