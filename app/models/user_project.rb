class UserProject < ActiveRecord::Base
  attr_accessible  :project_id, :user_id, :roleinproject_id
  validates_presence_of :roleinproject_id
  validates_numericality_of :id,  :project_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :roleinproject_id,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:roleinproject_id, :project_id]

  belongs_to :user
  belongs_to :project
  belongs_to :roleinproject

  def author_with_role
      [user.author_name, "(#{roleinproject.name})"].join(' ')
  end
end
