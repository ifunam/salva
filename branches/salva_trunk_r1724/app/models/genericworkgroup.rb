class Genericworkgroup < ActiveRecord::Base
  has_many :genericworktypes
  validates_numericality_of :id, :only_integer => true , :allow_nil => true

  validates_presence_of :name
  validates_uniqueness_of :name
end
