class Credittype < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :user_credits
end
