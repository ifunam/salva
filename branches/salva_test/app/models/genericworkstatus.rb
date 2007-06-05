class Genericworkstatus < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :name, :id
  validates_uniqueness_of :name
end
