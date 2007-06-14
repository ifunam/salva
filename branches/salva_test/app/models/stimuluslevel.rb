class Stimuluslevel < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :stimulustype_id
  validates_presence_of :name, :stimulustype_id
  validates_uniqueness_of :name
  validates_associated :stimulustype, :on => :update

  belongs_to :stimulustype
end
