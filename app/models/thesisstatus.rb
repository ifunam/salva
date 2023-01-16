class Thesisstatus < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_uniqueness_of :name
  # attr_accessor :name

  has_many :theses
  default_scope -> { order(name: :asc) }
end
