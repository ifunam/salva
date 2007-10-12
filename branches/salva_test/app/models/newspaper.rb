class Newspaper < ActiveRecord::Base
  validates_presence_of :name, :country_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :country_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  belongs_to :country
  validates_associated :country

  has_many :newspaperarticles
end
