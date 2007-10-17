class UserPrize < ActiveRecord::Base
validates_presence_of :prize_id, :year
validates_numericality_of :prize_id
belongs_to :prize
end
