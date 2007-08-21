class UserPrize < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :prize_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :year, :allow_nil => true, :only_integer => true
  validates_presence_of :prize_id, :year, :user_id
  validates_uniqueness_of :user_id, :scope => [:prize_id, :year]

  belongs_to :prize
  belongs_to :user
end
