class Regularcourse < ActiveRecord::Base
  validates_presence_of :title, :modality_id
  validates_numericality_of :id, :allow_nil => true, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :academicprogram_id, :modality_id, :semester, :greater_than => 0, :only_integer => true

  belongs_to :academicprogram
  belongs_to :modality

  validates_associated :academicprogram
  validates_associated :modality
end
