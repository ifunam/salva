# encoding: utf-8
class Academicprogram < ActiveRecord::Base
  attr_accessible :academicprogramtype_id, :year, :career_attributes
  validates_presence_of :academicprogramtype_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :academicprogramtype_id, :year,  :greater_than => 0, :only_integer => true

  belongs_to :institutioncareer # FIX IT: Remove this relationship until next release.
                                # We need institutioncareers table to support
                                # migrations from previous versions of salva databases.
  belongs_to :career
  accepts_nested_attributes_for :career
  belongs_to :academicprogramtype

  has_many :regularcourses

  def as_text
    ["Tipo de programa académico: #{academicprogramtype.name}", "Año del programa: #{year}"].join(', ')
  end

  def as_text_with_career
    [career.as_text, as_text].join(', ')
  end
end
