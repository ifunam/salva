class Stimulustype < ActiveRecord::Base
  validates_presence_of :name, :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :greater_than => 0, :only_integer => true

  validates_uniqueness_of :name

  belongs_to :institution
  validates_associated :institutions, :on => :update
  has_many :stimuluslevels
end
