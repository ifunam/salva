class UserStimulus < ActiveRecord::Base

  validates_presence_of :stimuluslevel_id, :startyear
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_numericality_of :user_id, :stimuluslevel_id, :startyear, :greater_than => 0, :only_integer => true
  validates_numericality_of :startmonth, :endyear, :endmonth, :allow_nil => true, :greater_than => 0, :only_integer => true
  belongs_to :stimuluslevel
  belongs_to :user
end

