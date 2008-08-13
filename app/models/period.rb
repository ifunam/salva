class Period < ActiveRecord::Base
  validates_presence_of :title, :startdate, :enddate
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :title, :scope => [:startdate, :enddate]
end
