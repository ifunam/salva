class Roleinjobposition < ActiveRecord::Base
  validates_presence_of :name
  # attr_accessor :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  has_many :jobpositioncategories
end
