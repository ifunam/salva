class Bookedition < ActiveRecord::Base

  validates_presence_of :edition, :mediatype_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of  :mediatype_id,  :greater_than => 0, :only_integer => true
  validates_numericality_of :editionstatus_id, :allow_nil => true, :greater_than => 0, :only_integer =>true

  belongs_to :book
  belongs_to :mediatype
  belongs_to :editionstatus


end
