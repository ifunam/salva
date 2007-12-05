class UserProject < ActiveRecord::Base
  validates_presence_of :project_id, :roleinproject_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :project_id, :roleinproject_id,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:roleinproject_id, :project_id]

  belongs_to :user
  belongs_to :project
  belongs_to :roleinproject

  validates_associated :project
  validates_associated :roleinproject
end
