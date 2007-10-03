class UserPrize < ActiveRecord::Base
  validates_presence_of :prize_id, :year, :user_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :prize_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :year, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:prize_id, :year]

  belongs_to :prize
  belongs_to :user
end
