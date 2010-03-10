class Acadvisit < ActiveRecord::Base
  validates_presence_of :institution_id, :country_id, :acadvisittype_id, :descr, :startyear
  validates_numericality_of :user_id, :institution_id, :country_id, :acadvisittype_id, :startyear, :greater_than => 0, :only_integer => true
  validates_numericality_of :endyear, :startmonth, :endmonth, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_inclusion_of :startmonth, :endmonth,  :in => 1..12, :allow_nil => true
  validates_uniqueness_of :id
  
  belongs_to :user
  belongs_to :institution
  belongs_to :country
  belongs_to :acadvisittype

  validates_associated :institution
  validates_associated :country
  validates_associated :acadvisittype

  has_many :projectacadvisits
end
