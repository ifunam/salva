class Project < ActiveRecord::Base
  validates_presence_of :name, :responsible, :descr, :projecttype_id, :projectstatus_id, :startyear
  validates_numericality_of :projecttype_id, :projectstatus_id

  belongs_to :projecttype
  belongs_to :projectstatus
  belongs_to :project
  
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
end
