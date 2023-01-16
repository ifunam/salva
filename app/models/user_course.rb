class UserCourse < ActiveRecord::Base
  # attr_accessor :user_id, :course_id, :roleincourse_id

  validates_presence_of :roleincourse_id
  validates_numericality_of :id, :course_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :roleincourse_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :course
  belongs_to :coursegroup
  belongs_to :roleincourse

  #default_scope :joins => :course, :order => 'courses.endyear DESC, courses.endmonth DESC, courses.startyear DESC, courses.startmonth DESC, courses.name ASC'
  scope :instructors, -> { joins(:roleincourse).where('roleincourses.id != 2') }
  scope :among, lambda { |sy,sm,ey,em|
    joins(:course).where("user_courses.course_id IN (#{Course.unscoped.select('DISTINCT(id)').between(sy,sm,ey,em).to_sql})")
  }
  scope :find_by_year, lambda { |year| joins(:course).where("courses.year = ?", year) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :among, :splat_param => true, :type => [:integer, :integer, :integer, :integer]
  # search_methods :adscription_id

  def author_with_role
    [user.author_name, "(#{roleincourse.name})"].join(' ')
  end
end
