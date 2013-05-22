class UserCourse < ActiveRecord::Base
  attr_accessible :user_id, :course_id, :roleincourse_id

  validates_presence_of :roleincourse_id
  validates_numericality_of :id, :course_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :roleincourse_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :course
  belongs_to :coursegroup
  belongs_to :roleincourse

  scope :find_by_year, lambda { |year| joins(:course).where("courses.year = ?", year) }

  def author_with_role
    [user.author_name, "(#{roleincourse.name})"].join(' ')
  end
end
