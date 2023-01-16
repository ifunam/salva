class Acadvisittype < ActiveRecord::Base
  has_many :acadvisits
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_presence_of :name
  validates_uniqueness_of :name
  default_scope -> { order(name: :asc) }
end
