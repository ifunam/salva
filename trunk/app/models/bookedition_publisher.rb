class BookeditionPublisher < ActiveRecord::Base
validates_presence_of :bookedition_id, :publisher_id
validates_numericality_of :bookedition_id, :publisher_id
belongs_to :bookedition
belongs_to :publisher
end
