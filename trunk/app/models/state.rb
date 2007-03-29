class State < ActiveRecord::Base
  validates_presence_of :country_id, :name
  validates_numericality_of :country_id
  validates_inclusion_of :country_id, :in => 1..999
  validates_length_of :code, :in => 2..3, :allow_nil => true
  validates_uniqueness_of :name, :scope => [:country_id]

  belongs_to :country
end
