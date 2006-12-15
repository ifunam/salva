class City < ActiveRecord::Base
  validates_presence_of :state_id, :name
  validates_numericality_of :state_id
  validates_uniqueness_of :name, :scope => [:state_id]

  belongs_to :state
end
