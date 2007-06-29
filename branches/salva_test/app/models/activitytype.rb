class Activitytype < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :activitygroup_id

  validates_presence_of :name, :activitygroup_id

  belongs_to :activitygroup
end
