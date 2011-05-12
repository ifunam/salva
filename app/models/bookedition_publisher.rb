class BookeditionPublisher < ActiveRecord::Base
  validates_numericality_of :id, :book_edition_id, :publisher_id,
                            :allow_nil => true, :greater_than => 0,
                            :only_integer => true
  validates_uniqueness_of :bookedition_id, :scope => [:publisher_id]

  belongs_to :bookedition
  belongs_to :publisher
end
