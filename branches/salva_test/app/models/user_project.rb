class UserProject < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :project_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :roleinproject_id, :allow_nil => true, :only_integer => true

  validates_presence_of :project_id, :roleinproject_id

  validates_uniqueness_of :project_id, :scope => [:roleinproject_id, :user_id]

  belongs_to :user
  belongs_to :project
  belongs_to :roleinproject
end
