class Country < ActiveRecord::Base
  validates_numericality_of :id
  validates_inclusion_of :id, :in => 1..999
  validates_presence_of :id, :name, :citizen, :code
  validates_length_of :code, :within => 2..3
  validates_uniqueness_of :name, :code, :id
  
  has_many :state
  has_many :citizen
end
