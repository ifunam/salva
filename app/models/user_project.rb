class UserProject < ActiveRecord::Base
  # attr_accessor  :project_id, :user_id, :roleinproject_id
  validates_presence_of :roleinproject_id
  validates_numericality_of :id,  :project_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :roleinproject_id,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:roleinproject_id, :project_id]

  belongs_to :user
  belongs_to :project
  belongs_to :roleinproject

  #default_scope :joins => :project, :order => 'projects.startyear DESC, projects.startmonth DESC'

  scope :user_id_not_eq, lambda { |user_id|
    select('DISTINCT(project_id) as project_id').where(["user_projects.user_id !=  ?", user_id])
  }

  scope :user_id_eq, lambda { |user_id|
    select('DISTINCT(project_id) as project_id').where :user_id => user_id
  }

  scope :among, lambda { |sy,sm,ey,em|
    joins(:project).where("user_projects.project_id IN (#{Project.unscoped.select('DISTINCT(id)').among(sy,sm,ey,em).to_sql})")
  }

  scope :projectstatus_id, lambda { |id|
    joins(:project).where('projects.projectstatus_id = ?', id)
  }

  scope :adscription_id, lambda { |id|
    joins(:user => :user_adscription)
      .where(:user => {:user_adscription => {:adscription_id => id}})
  }

  # search_methods :among, :splat_param => true, :type => [:integer, :integer, :integer, :integer]
  # search_methods :adscription_id, :projectstatus_id

  def author_with_role
    [user.author_name, "(#{roleinproject.name})"].join(' ')
  end
end
