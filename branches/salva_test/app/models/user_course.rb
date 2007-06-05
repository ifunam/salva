class UserCourse < ActiveRecord::Base
  validates_presence_of :roleincourse_id
  validates_numericality_of :course_id, :roleincourse_id
  belongs_to :course
  belongs_to :coursegroup
  belongs_to :roleincourse
end
