class UserCourse < ActiveRecord::Base
  validates_numericality_of :id, :only_integer => true, :allow_nil => true
  validates_presence_of :course_id, :roleincourse_id
  validates_numericality_of :user_id, :course_id, :roleincourse_id, :only_integer => true
  belongs_to :course
  belongs_to :coursegroup
  belongs_to :roleincourse
end
