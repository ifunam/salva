class UserSchoolarship < ActiveRecord::Base
  validates_presence_of :schoolarship_id, :user_id, :startyear
  validates_numericality_of :schoolarship_id, :user_id, :startyear, :allow_nil => false,  :greater_than => 0, :only_integer => true
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :schoolarship_id, :scope => [:user_id, :startyear, :startmonth]
belongs_to :schoolarship
end
