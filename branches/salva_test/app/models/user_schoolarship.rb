class UserSchoolarship < ActiveRecord::Base
validates_presence_of :schoolarship_id, :startyear
validates_numericality_of :id, :allow_nil => true, :only_integer => true
validates_numericality_of :schoolarship_id, :startyear, :user_id, :only_integer => true
belongs_to :schoolarship
validates_uniqueness_of :schoolarship_id, :user_id, :startyear
end
