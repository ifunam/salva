class Activitygroup < ActiveRecord::Base
  validates_numericality_of :id, :only_integer => true, :allow_nil => true
  validates_presence_of :name, :id
  validates_uniqueness_of :id, :name
  validates_length_of :name, :within => 4..50
end
