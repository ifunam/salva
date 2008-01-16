class UserCourse < ActiveRecord::Base
  validates_presence_of :roleincourse_id
  validates_numericality_of :id, :course_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :roleincourse_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :course
  belongs_to :coursegroup
  belongs_to :roleincourse

  validates_associated :course
  validates_associated :coursegroup
  validates_associated :roleincourse
end
