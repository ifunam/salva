class State < ActiveRecord::Base
  validates_presence_of :country_id, :name
  validates_numericality_of :country_id
  validates_uniqueness_of :name, :scope => [:country_id]

  belongs_to :country
end
