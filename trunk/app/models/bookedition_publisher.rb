class BookeditionPublisher < ActiveRecord::Base
  validates_presence_of :bookedition_id, :publisher_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :bookedition_id, :publisher_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :bookedition_id, :scope => [:publisher_id]

  belongs_to :bookedition
  belongs_to :publisher

  validates_associated :bookedition
  validates_associated :publisher
end
