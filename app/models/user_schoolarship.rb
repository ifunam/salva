class UserSchoolarship < ActiveRecord::Base
  validates_presence_of :schoolarship_id, :start_date
  validates_numericality_of :schoolarship_id, :allow_nil => false,  :greater_than => 0, :only_integer => true
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  # validates_uniqueness_of :schoolarship_id, :scope => [:user_id, :start_date]
  belongs_to :schoolarship
end
