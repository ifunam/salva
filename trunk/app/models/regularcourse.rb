class Regularcourse < ActiveRecord::Base
  validates_presence_of :title, :modality_id
  validates_numericality_of :id, :semester, :credits, :academicprogram_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :modality_id,  :greater_than => 0, :only_integer => true
  belongs_to :academicprogram
  belongs_to :modality
end
