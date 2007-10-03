class State < ActiveRecord::Base
  validates_presence_of :country_id, :name
  validates_numericality_of :id,  :greater_than => 0, :only_integer => true
  validates_numericality_of :country_id,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:country_id]

  belongs_to :country
  has_many :cities
  has_many :people

  validates_associated :country
end
