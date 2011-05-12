class BookeditionRoleinbook < ActiveRecord::Base
  belongs_to :bookedition
  belongs_to :roleinbook
  belongs_to :user
end
