class Project < ActiveRecord::Base
  # attr_accessor :name, :abbrev, :responsible, :descr, :projecttype_id, :startyear, :startmonth, :endyear, :endmonth,
                  :projectfinancingsources_attributes, :projectstatus_id, :user_projects_attributes

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :projectstatus_id, :projectstatus_id, :startyear,:projecttype_id, :greater_than => 0, :only_integer => true
  validates_presence_of :name, :responsible, :descr, :projecttype_id, :projectstatus_id, :startyear

  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  belongs_to :projecttype
  belongs_to :projectstatus
  belongs_to :project

  has_many :user_projects
  has_many :users, :through => :user_projects
  accepts_nested_attributes_for :user_projects
  user_association_methods_for :user_projects

  has_many :projectfinancingsources
  has_many :institutions, :through => :projectfinancingsources
  accepts_nested_attributes_for :projectfinancingsources, :reject_if => proc { |attrs| attrs['institution_id'] == '0' }

  has_many :projectinstitutions
  has_many :projectresearchlines
  has_many :projectresearchareas
  has_many :projectarticles
  # has_many :projectbooks
  # has_many :projectchapterinbooks
  # has_many :projectconferencetalks
  # has_many :projectacadvisits
  # has_many :projectgenericworks
  # has_many :projecttheses

  has_paper_trail

  default_scope -> { order(startyear: :desc, startmonth: :desc) }
  scope :user_id_eq, lambda { |user_id| joins(:user_projects).where(:user_projects => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id| 
    project_without_user_sql = UserProject.user_id_not_eq(user_id).to_sql
    project_with_user_sql = UserProject.user_id_eq(user_id).to_sql
    sql = "projects.id IN (#{project_without_user_sql}) AND projects.id NOT IN (#{project_with_user_sql})"
    where sql
  }
  # search_methods :user_id_eq, :user_id_not_eq

  def to_s
    [name, "Responsable: #{responsible}", "Tipo: #{projecttype.name}", "Status: #{projectstatus.name}", start_date, end_date].join(', ')
  end

  def financing_source_names
    projectfinancingsources.collect { |pfs|
      pfs.institution.name_and_parent_abbrev
    }.compact.join(', ')
  end
end
