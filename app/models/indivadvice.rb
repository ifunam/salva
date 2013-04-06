# encoding: utf-8
class Indivadvice < ActiveRecord::Base
  attr_accessible :indivname, :institution_id, :startyear, :startmonth, :endyear, :endmonth,
                  :hours, :indivadvicetarget_id, :career_attributes

  validates_presence_of :indivadvicetarget_id, :indivname, :startyear, :hours
  validates_numericality_of :indivadvicetarget_id
  belongs_to :user
  belongs_to :indivuser, :class_name => "User", :foreign_key => "indivuser_id"


  belongs_to :indivadvicetarget
  belongs_to :indivadviceprogram
  belongs_to :institution

  # Fix It: Remove degree relationship in the next release
  belongs_to :degree
  belongs_to :career # Used only for students
  accepts_nested_attributes_for :career

  belongs_to :registered_by, :class_name => "User"
  belongs_to :modified_by, :class_name => "User"

  default_scope :order => 'endyear DESC, endmonth DESC, startyear DESC, startmonth DESC, indivname ASC'
  scope :students, where('indivadvicetarget_id <= 3')
  scope :professors, where('indivadvicetarget_id > 3')

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
    unless career_id.nil?
      "Grado: #{career.degree.name}"
    else
      "Grado: #{degree.name}" unless degree_id.nil?
    end
  end

  def career_name
    "Carrera: #{career.name}" unless career_id.nil?
  end

  def institution_name
    unless career_id.nil?
      career.institution.school_and_university_names
    else
      institution.school_and_university_names unless institution_id.nil?
    end
  end

  def normalized_hours
    "Número de horas: #{hours}" unless hours.nil?
  end
end
