class Activity < ActiveRecord::Base
  validates_presence_of :name, :activitytype_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :activitytype_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  belongs_to :activitytype
  belongs_to :user

  validates_associated :activitytype
  validates_associated :user
end
