class Courseduration < ActiveRecord::Base
  has_many :courses

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :days,  :only_integer => true

  validates_presence_of :name,  :days
  validates_uniqueness_of :name
end
