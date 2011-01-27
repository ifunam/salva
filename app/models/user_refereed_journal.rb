class UserRefereedJournal < ActiveRecord::Base
  validates_presence_of :year
  belongs_to :user
  belongs_to :journal
  belongs_to :refereed_criterium
end
