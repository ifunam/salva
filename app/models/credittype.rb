class Credittype < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :user_credits
end
