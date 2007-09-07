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

  validates_numericality_of :projecttype_id,:allow_nil => true, :only_integer => true
  validates_numericality_of :projectstatus_id,:allow_nil => true, :only_integer => true
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :startyear

  validates_presence_of :name, :responsible, :descr, :projecttype_id, :projectstatus_id, :startyear
  validates_uniqueness_of :name, :scope => [:startyear, :responsible]

  belongs_to :projecttype
  belongs_to :projectstatus
  belongs_to :project

  validates_associated :projecttype, :on => :update
  validates_associated :projectstatus, :on => :update
  validates_associated :project, :on => :update
end
