class Coursegroup < ActiveRecord::Base
  validates_presence_of :name, :coursegrouptype_id, :startyear
  validates_numericality_of :id,  :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :coursegrouptype_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:coursegrouptype_id, :startyear, :startmonth, :endyear, :endmonth]

  belongs_to :coursegrouptype
  validates_associated :coursegrouptype

  has_many :courses
  has_many :user_courses
end
