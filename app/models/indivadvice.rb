# encoding: utf-8
class Indivadvice < ActiveRecord::Base
  validates_presence_of :indivadvicetarget_id, :indivname, :startyear, :hours
  validates_numericality_of :indivadvicetarget_id
  belongs_to :user
  belongs_to :indivuser, :class_name => "User", :foreign_key => "indivuser_id"
  belongs_to :institution
  belongs_to :indivadvicetarget
  belongs_to :indivadviceprogram
  belongs_to :degree
  belongs_to :career
  belongs_to :registered_by, :class_name => "User"
  belongs_to :modified_by, :class_name => "User"

  default_scope :order => 'startyear DESC, startmonth DESC, endyear DESC, endmonth DESC, indivname ASC'
  scope :students, where('indivadvicetarget_id <= 3')
  scope :professors, where('indivadvicetarget_id > 3')

  def as_text
    [normalized_indivname, indivadvicetarget.name, degree_name, career_name, institution_name, start_date, end_date, normalized_hours].compact.join(', ')
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
    institution.name_and_parent_abbrev unless institution_id.nil?
  end

  def normalized_hours
    "Número de horas: #{hours}" unless hours.nil?
  end
end
