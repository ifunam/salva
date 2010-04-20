class User < ActiveRecord::Base
   validates_presence_of :login, :userstatus_id
#  acts_as_authentic do |c|
#    c.logged_in_timeout = 120.minutes
#  end
  has_one :person
  has_one :address
  accepts_nested_attributes_for :person, :address
end
