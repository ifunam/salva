class Academicprogram < ActiveRecord::Base
  validates_presence_of :academicprogramtype_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :academicprogramtype_id, :year,  :greater_than => 0, :only_integer => true

  belongs_to :institutioncareer
  belongs_to :academicprogramtype

end
