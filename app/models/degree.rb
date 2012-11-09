class Degree < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_uniqueness_of :name
  has_many :careers
  has_many :indivadvices
  has_many :tutorial_committees
  has_many :thesismodalities
  default_scope :order => 'name ASC'

  scope :higher, where('id > 1')
end
