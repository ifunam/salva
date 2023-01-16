class Idtype < ActiveRecord::Base
  # attr_accessor :name
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :user_identifications
  default_scope -> { order(name: :asc) }
end
