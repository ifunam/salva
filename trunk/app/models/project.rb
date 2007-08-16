class Project < ActiveRecord::Base
  has_many :projectinstitution
  has_many :projectfinancingsource
  has_many :projectresearchline
  has_many :projectresearcharea
  has_many :projectarticle
  has_many :projectbook
  has_many :projectchapterinbook
  has_many :projectconferencetalk
  has_many :projectacadvisit
  has_many :projectgenericwork

  validates_numericality_of :projecttype_id,:allow_nil => true, :only_integer => true
  validates_numericality_of :projectstatus_id,:allow_nil => true, :only_integer => true
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :startyear

  validates_presence_of :name, :responsible, :descr, :projecttype_id, :projectstatus_id, :startyear
  validates_uniqueness_of :name, :scope => [:startyear, :responsible]

  belongs_to :projecttype
  belongs_to :projectstatus
  belongs_to :project
end
