class Thesisstatus < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :within => 4..50
end
