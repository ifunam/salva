class UserCourse < ActiveRecord::Base
  attr_accessor :degree_id

  validates_presence_of :roleincourse_id, :country_id, :courseduration_id, :modality_id, :year
  validates_numericality_of :coursegroup_id, :roleincourse_id, :institution_id, :country_id, :courseduration_id

  belongs_to :courses
  belongs_to :coursegroup
  belongs_to :roleincourse
  belongs_to :institution
  belongs_to :country
  belongs_to :courseduration
end
