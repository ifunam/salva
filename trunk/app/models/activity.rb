class Activity < ActiveRecord::Base
  attr_accessor :activitygroup_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :activitytype_id, :only_integer => true
  validates_numericality_of :user_id, :only_integer => true

  validates_presence_of :name, :activitytype_id, :user_id, :year
  validates_uniqueness_of :name
  belongs_to :activitytype
  belongs_to :user
end
