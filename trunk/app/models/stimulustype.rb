class Stimulustype < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :name, :id
  validates_uniqueness_of :id, :name
  validates_length_of :name, :within => 4..50
  validates_associated :institutions, :on => :update
belongs_to :institution
end
