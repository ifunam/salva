class Stimuluslevel < ActiveRecord::Base

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :name, :id
  validates_uniqueness_of :id, :name
  validates_length_of :name, :within => 1..3
  validates_associated :stimulustype, :on => :update

  belongs_to :stimulustype
end
