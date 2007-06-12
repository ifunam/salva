class Addresstype < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :within => 2..30
end
