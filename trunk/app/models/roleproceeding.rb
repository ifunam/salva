class Roleproceeding < ActiveRecord::Base
  validates_presence_of :id
  validates_numericality_of :id, :only_integer => true 
  validates_presence_of :name
  validates_uniqueness_of :name
end
