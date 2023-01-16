class UserStimulus < ActiveRecord::Base
  # attr_accessor :stimuluslevel_id, :startyear, :startmonth, :endyear, :endmonth

  validates_presence_of :stimuluslevel_id, :startyear
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_numericality_of :user_id, :stimuluslevel_id, :startyear, :greater_than => 0, :only_integer => true
  validates_numericality_of :startmonth, :endyear, :endmonth, :allow_nil => true, :greater_than => 0, :only_integer => true
  belongs_to :stimuluslevel
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  def to_s
    [stimuluslevel.name_and_type, start_date, end_date].compact.join(', ')
  end
end

