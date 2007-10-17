class Academicprogram < ActiveRecord::Base
  validates_presence_of :institutioncareer_id, :academicprogramtype_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institutioncareer_id, :academicprogramtype_id, :year,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :institutioncareer_id, :scope => [:year]

  belongs_to :institutioncareer
  belongs_to :academicprogramtype

  validates_associated :institutioncareer
  validates_associated :academicprogramtype
end
