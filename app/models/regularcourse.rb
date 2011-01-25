class Regularcourse < ActiveRecord::Base
  validates_presence_of :title, :modality_id
  validates_numericality_of :id, :semester, :credits, :academicprogram_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :modality_id,  :greater_than => 0, :only_integer => true

  belongs_to :academicprogram
  accepts_nested_attributes_for :academicprogram
  belongs_to :modality

  def as_text
    sem = semester == 0 ? nil : "Semestre: #{semester}"
    cred = credits.nil? ? nil : "Créditos: #{credits}"
    [title, "Modalidad: #{modality.name}", sem, cred, academicprogram.as_text_with_career].compact.join(', ')
  end
end
