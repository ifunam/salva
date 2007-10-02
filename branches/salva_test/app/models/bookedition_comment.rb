class BookeditionComment < ActiveRecord::Base
  validates_presence_of :user_id, :bookedition_id

  belongs_to :bookedition
  belongs_to :user
end
