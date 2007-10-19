class Acadvisit < ActiveRecord::Base
  validates_presence_of :institution_id, :country_id, :acadvisittype_id, :descr, :startyear

   validates_numericality_of :id, :externaluser_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :id, :externaluser_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :institution_id, :country_id, :acadvisittype_id, :startyear, :greater_than => 0, :only_integer => true
  validates_numericality_of :endyear, :startmonth, :endmonth, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_inclusion_of :startmonth, :endmonth,  :in => 1..12, :allow_nil => true
  validates_uniqueness_of :descr

  belongs_to :user
  belongs_to :institution
  belongs_to :country
  belongs_to :acadvisittype
  belongs_to :externaluser

  validates_associated :institution
  validates_associated :country
  validates_associated :acadvisittype
  validates_associated :externaluser
  validates_associated :user

  has_many :projectacadvisits


# def validate
#      errors.add(:startyear, "La fecha de inicio no debe ser posterior")  || endyear < staryear
#  end
end
