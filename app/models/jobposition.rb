class Jobposition < ActiveRecord::Base
  set_table_name "jobpositions"

  validates_presence_of :institution_id, :start_date

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :greater_than => 0, :only_integer => true

  validates_numericality_of :jobpositioncategory_id, :contracttype_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_numericality_of :startmonth, :endmonth, :startyear, :endyear, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:institution_id, :startyear]

  belongs_to :jobpositioncategory
  belongs_to :contracttype
  belongs_to :institution
  belongs_to :user

  has_many :user_adscriptions

  has_one :user_adscription
  accepts_nested_attributes_for :user_adscription

  validates_associated :jobpositioncategory
  validates_associated :contracttype
  validates_associated :institution
end
