class State < ActiveRecord::Base
  validates_presence_of :country_id, :name
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :country_id,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:country_id]
  # attr_accessor :country_id, :name, :code

  belongs_to :country
  validates_associated :country

  has_many :cities
  has_many :people
  has_many :addresses
  has_many :institutions

  default_scope -> { order(name: :asc) }
end
