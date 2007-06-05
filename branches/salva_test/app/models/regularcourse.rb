class Regularcourse < ActiveRecord::Base
  validates_presence_of :title, :modality_id
  validates_numericality_of :academicprogram_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :modality_id, :only_integer => true
  validates_numericality_of :semester, :allow_nil => true, :only_integer => true
  belongs_to :academicprogram
  belongs_to :modality
end
