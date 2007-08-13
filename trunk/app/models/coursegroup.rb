class Coursegroup < ActiveRecord::Base
  has_many :courses
  validates_numericality_of :id,  :allow_nil => true,  :only_integer => true
  validates_numericality_of :coursegrouptype_id, :allow_nil => true,  :only_integer => true

  validates_presence_of :name, :coursegrouptype_id, :startyear
  validates_uniqueness_of :name, :scope => [:startyear]

  belongs_to :coursegrouptype
end
