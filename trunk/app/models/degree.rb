class Degree < ActiveRecord::Base
  validates_presence_of :name, :id
  validates_numericality_of :id, :only_integer => true 
  validates_inclusion_of:id, :in => 1..100 
  validates_uniqueness_of :id

  has_many :careers, :through => :careers
  validates_associated :career
end
