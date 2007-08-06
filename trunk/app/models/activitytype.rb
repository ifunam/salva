class Activitytype < ActiveRecord::Base
  has_many :activities
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :activitygroup_id, :only_integer => true

  validates_presence_of :name, :activitygroup_id
  validates_uniqueness_of  :name
  belongs_to :activitygroup
end
