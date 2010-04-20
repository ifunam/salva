class User < ActiveRecord::Base
  validates_presence_of :login, :userstatus_id
  has_one :person
  has_one :address
  accepts_nested_attributes_for :person, :address
end
