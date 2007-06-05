class City < ActiveRecord::Base
  validates_presence_of :state_id, :name
  validates_numericality_of :state_id
  validates_inclusion_of :state_id, :within => 1..10000
  validates_uniqueness_of :name, :scope => [:state_id]

  belongs_to :state
end
