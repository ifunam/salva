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

  default_scope :order => 'startyear DESC, startmonth DESC, endyear DESC, endmonth DESC, indivname ASC'
  scope :students, where('indivadvicetarget_id <= 3')
  scope :professors, where('indivadvicetarget_id > 3')

  def to_s
    [normalized_indivname, indivadvicetarget.name, degree_name, career_name, institution_name, start_date, end_date, normalized_hours].compact.join(', ')
  end

  def normalized_indivname
    prefix = indivadvicetarget_id > 3 ? 'Académico' : 'Estudiante'
    "#{prefix}: #{indivname}"
  end

  def degree_name
    if !degree_id.nil?
      "Grado: #{degree.name}"
    elsif !career.nil?
      "Grado: #{career.degree.name}"
    end

  end

  def career_name
    "Carrera: #{career.name}" unless career_id.nil?
  end

  def institution_name
    if !institution_id.nil?
      institution.name_and_parent_abbrev
    elsif !career.nil?
      career.institution.name_and_parent_abbrev
    end
  end

  def normalized_hours
    "Número de horas: #{hours}" unless hours.nil?
  end
end
