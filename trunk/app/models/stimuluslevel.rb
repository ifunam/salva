class Stimuluslevel < ActiveRecord::Base
  validates_presence_of :name, :stimulustype_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :stimulustype_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:stimulustype_id]

  belongs_to :stimulustype

  validates_associated :stimulustype
end
