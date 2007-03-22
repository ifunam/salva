class Academicprogram < ActiveRecord::Base
  attr_accessor :degree_id

  validates_presence_of :institutioncareer_id, :academicprogramtype_id, :year
  validates_numericality_of :institutioncareer_id, :academicprogramtype_id, :year

  belongs_to :institutioncareer
  belongs_to :academicprogramtype
end
