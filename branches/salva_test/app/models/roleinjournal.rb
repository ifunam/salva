class Roleinjournal < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_inclusion_of :id, :in => 1..999
  validates_presence_of :name
  validates_uniqueness_of :name
end
