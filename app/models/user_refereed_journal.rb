# encoding: utf-8
class UserRefereedJournal < ActiveRecord::Base
  validates_presence_of :year
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => :registered_by_id
  belongs_to :modified_by, :class_name => 'User', :foreign_key => :modified_by_id
  belongs_to :journal
  belongs_to :refereed_criterium

  def as_text
    ["Árbitro de #{refereed_criterium.name}", journal.name, date].compact.join(', ')
  end
end
