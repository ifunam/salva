class Courseduration < ActiveRecord::Base
  validates_presence_of :name,  :days

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :days, :greater_than =>0, :only_integer => true

  validates_uniqueness_of :name

  default_scope :order => 'name ASC'

  has_many :courses
end
