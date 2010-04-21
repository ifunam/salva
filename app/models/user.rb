class User < ActiveRecord::Base
  validates_presence_of :login, :userstatus_id

  belongs_to :userstatus
  belongs_to :user_incharge, :class_name => 'User', :foreign_key => 'user_incharge_id'

  has_one :person
  has_one :address
  accepts_nested_attributes_for :person, :address
end
