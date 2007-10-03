class Researchline < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :researcharea_id, :only_integer => true
  validates_uniqueness_of :name

  belongs_to :researcharea
  has_many :projectresearchlines
  has_many :user_researchlines

  validates_associated  :researcharea
 end
