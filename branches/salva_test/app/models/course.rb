class Course < ActiveRecord::Base
  validates_presence_of :name, :country_id, :courseduration_id, :modality_id, :startyear
  validates_numericality_of :country_id, :institution_id, :courseduration_id, :modality_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_uniqueness_of :name, :startyear

  belongs_to :country
  belongs_to :institution
  belongs_to :coursegroup
  belongs_to :courseduration
  belongs_to :modality
end
