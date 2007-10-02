class City < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true,  :only_integer => true
  validates_numericality_of :state_id, :allow_nil => true,  :only_integer => true

  validates_presence_of :state_id, :name
  validates_uniqueness_of :name, :scope => [:state_id]
  belongs_to :state
end
