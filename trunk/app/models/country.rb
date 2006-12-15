class Country < ActiveRecord::Base
  validates_presence_of :id, :name, :citizen, :code
  validates_numericality_of :id
  validates_uniqueness_of :name, :code
end
