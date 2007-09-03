class UserCourse < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :roleincourse_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :course_id, :allow_nil => true, :only_integer => true
  validates_presence_of :roleincourse_id
  validates_numericality_of :course_id, :roleincourse_id

  belongs_to :course
  belongs_to :coursegroup
  belongs_to :roleincourse
end
