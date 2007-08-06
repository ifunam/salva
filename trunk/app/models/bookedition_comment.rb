class BookeditionComment < ActiveRecord::Base
  validates_presence_of :user_id, :message => "Proporcione el user_id"
#  validates_presence_of :bookedition_id, :message => "Proporcione el bookedition_id"

  belongs_to :bookedition
  belongs_to :user
end
