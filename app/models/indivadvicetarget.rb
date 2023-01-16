class Indivadvicetarget < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  has_many :instadvices

  default_scope -> { order(name: :asc) }
  scope :students, -> { where('id <= 3') }
  scope :professors, -> { where('id > 3') }
end
