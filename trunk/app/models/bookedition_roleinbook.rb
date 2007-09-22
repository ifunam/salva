class BookeditionRoleinbook < ActiveRecord::Base
  validates_presence_of :bookedition_id
  validates_presence_of :roleinbook_id
  validates_presence_of :user_id
  validates_uniqueness_of :user_id, :scope => [:bookedition_id, :roleinbook_id]
  belongs_to :bookedition
  belongs_to :roleinbook
 belongs_to :user
end
