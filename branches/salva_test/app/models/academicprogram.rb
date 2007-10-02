class Academicprogram < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :institutioncareer_id, :academicprogramtype_id, :year
  validates_numericality_of :institutioncareer_id, :academicprogramtype_id, :year
  validates_uniqueness_of :institutioncareer_id, :scope => [:academicprogramtype_id, :year]

  belongs_to :institutioncareer
  belongs_to :academicprogramtype
end
