class City < ActiveRecord::Base
  validates_presence_of :state_id, :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :state_id, :greater_than => 0, :only_integer => true

  validates_uniqueness_of :name, :scope => [:state_id]
  belongs_to :state
  validates_associated :state
end
