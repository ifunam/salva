class Researchline < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :researcharea_id, :allow_nil => true, :only_integer => true

  belongs_to :researcharea
  has_many :projectresearchlines
end
