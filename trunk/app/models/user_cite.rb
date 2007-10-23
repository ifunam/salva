class UserCite < ActiveRecord::Base
  validates_presence_of :total
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of  :user_id

  belongs_to :user
  validates_associated :user
end
