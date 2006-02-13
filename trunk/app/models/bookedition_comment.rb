class BookeditionComment < ActiveRecord::Base
  belongs_to :bookedition
  belongs_to :user
end
