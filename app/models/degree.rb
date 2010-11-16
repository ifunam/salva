class Degree < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_uniqueness_of :name
  #has_many :careers, :through => :careers
  has_many :careers
  has_many :indivadvices
  #has_many :externalusers
  has_many :tutorial_committees
end
