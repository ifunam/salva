class Project < ActiveRecord::Base
  has_many :projectinstitutions
  has_many :projectfinancingsources
  has_many :projectresearchlines
  has_many :projectresearchareas
  has_many :projectarticles
  has_many :projectbooks
  has_many :projectchapterinbooks
  has_many :projectconferencetalks
  has_many :projectacadvisits
  has_many :projectgenericworks
  has_many :projecttheses

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :projectstatus_id, :projectstatus_id, :startyear,:projecttype_id, :greater_than => 0, :only_integer => true

  validates_presence_of :name, :responsible, :descr, :projecttype_id, :projectstatus_id, :startyear
  #validates_uniqueness_of :name, :scope => [:startyear, :responsible]

  belongs_to :projecttype
  belongs_to :projectstatus
  belongs_to :project

  validates_associated :projecttype
  validates_associated :projectstatus
  validates_associated :project
end
