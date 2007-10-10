class Jobposition < ActiveRecord::Base
  set_table_name "jobpositions"

  validates_presence_of :institution_id, :startyear
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :greater_than => 0, :only_integer => true

  validates_numericality_of :jobpositioncategory_id, :contracttype_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_numericality_of :user_id, :startyear, :greater_than => 0, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:institution_id, :startyear]

  belongs_to :jobpositioncategory
  belongs_to :contracttype
  belongs_to :institution
  belongs_to :user
  has_many :user_adscriptions

  validates_associated :jobpositioncategory
  validates_associated :contracttype
  validates_associated :institution
  validates_associated :user
end
