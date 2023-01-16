class Roleinbook < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  has_many :bookedition_roleinbooks

  default_scope -> { order(name: :asc) }
  scope :authors, -> { where("id = 1 OR id = 2") }
  scope :collaborators, -> { where("id != 1 AND id != 2") }
end
