# encoding: utf-8
class Course < ActiveRecord::Base
  # attr_accessor :name, :courseduration_id, :modality_id, :hoursxweek, :totalhours, :startyear,
    :startmonth, :endyear, :endmonth, :country_id, :location, :user_courses_attributes

  validates_presence_of :name, :country_id, :courseduration_id, :modality_id, :startyear
  validates_numericality_of :country_id,  :courseduration_id, :modality_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  normalize_attributes :name, :location

  belongs_to :country
  belongs_to :institution
  belongs_to :coursegroup
  belongs_to :courseduration
  belongs_to :modality
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :user_courses
  has_many :users, :through => :user_courses
  accepts_nested_attributes_for :user_courses
  user_association_methods_for :user_courses

  has_paper_trail

  default_scope -> { order(courses: {endyear: :desc, endmonth: :desc, startyear: :desc, endmonth: :desc, name: :asc }) }
  scope :attendees, -> { joins(:user_courses).where(:user_courses => { :roleincourse_id => 2 }) }
  scope :instructors, -> { joins(:user_courses).where('user_courses.roleincourse_id != 2') }

  scope :user_id_eq, lambda { |user_id| joins(:user_courses).where(:user_courses => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|  where("courses.id IN (#{UserCourse.select('DISTINCT(course_id) as course_id').where(["user_courses.user_id !=  ?", user_id]).to_sql}) AND courses.id  NOT IN (#{UserCourse.select('DISTINCT(course_id) as course_id').where(["user_courses.user_id =  ?", user_id]).to_sql})") }
  scope :between, lambda { |start_year, start_month, end_year, end_month|
    where{
      ({:startyear.gteq => start_year, :startmonth.gteq => start_month, :endyear.lteq => end_year, :endmonth.lteq => end_month}) |
      ({:startyear.lteq => start_year, :endyear.gteq => end_year }) |
      ({:startyear.gteq => start_year, :endyear.gteq => end_year }) |
      ({:startyear.gteq => start_year, :endyear => nil })
    }
  }

  # search_methods :between, :splat_param => true, :type => [:integer, :integer, :integer, :integer]
  # search_methods :user_id_eq, :user_id_not_eq

  def to_s
    [ name, "Duración: #{courseduration.name}", "Modalidad: #{modality.name}",
      normalized_hoursxweek, normalized_totalhours, location,
      "País: #{country.name}", start_date, end_date].compact.join(', ')
  end

  def normalized_hoursxweek
    "Horas por semana: #{hoursxweek}" unless hoursxweek.nil?
  end

  def normalized_totalhours
    "Total de horas: #{totalhours.to_s.to_i}" unless totalhours.nil?
  end
end
