class State < ActiveRecord::Base
  has_many :city
  validates_numericality_of :id,         :allow_nil => true,  :only_integer => true
  validates_numericality_of :country_id, :allow_nil => true,  :only_integer => true

  validates_presence_of :country_id, :name
  validates_uniqueness_of :name, :scope => [:country_id]

  belongs_to :country
end
