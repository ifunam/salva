class Edition < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_inclusion_of :id, :in => 1..100

  validates_presence_of :name
  validates_length_of :name, :within => 1..250
  validates_uniqueness_of :name
end
