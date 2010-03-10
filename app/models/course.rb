class Course < ActiveRecord::Base
  validates_presence_of :name, :country_id, :courseduration_id, :modality_id, :startyear
  validates_numericality_of :country_id,  :courseduration_id, :modality_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true

  belongs_to :country
  belongs_to :institution
  belongs_to :coursegroups
  belongs_to :courseduration
  belongs_to :modality


  has_many :user_courses
end
