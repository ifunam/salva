class UserInproceeding < ActiveRecord::Base
  validates_presence_of :inproceeding_id
  validates_numericality_of :inproceeding_id

  belongs_to :inproceeding
  belongs_to :user
end
