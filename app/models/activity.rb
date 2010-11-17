class Activity < ActiveRecord::Base
  attr_accessor :activitygroup_id
  validates_presence_of :name, :activitytype_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :activitytype_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  belongs_to :activitytype
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  defaults_scope :order => 'year DESC, month DESC, name ASC'
  scope :other, where(:activitytype_id => 15)
end
