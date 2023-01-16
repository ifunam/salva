class Period < ActiveRecord::Base
  validates_presence_of :title, :startdate, :enddate
  # attr_accessor :title, :startdate, :enddate
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :title, :scope => [:startdate, :enddate]

  has_many :user_regularcourses
  has_many :regularcourses, :through => :user_regularcourses

  default_scope -> { order('periods.startdate DESC').includes(user_regularcourses: :regularcourse) }
end
