class UserProject < ActiveRecord::Base
  validates_presence_of :project_id, :roleinproject_id
  validates_numericality_of :project_id, :roleinproject_id
  belongs_to :project
  belongs_to :roleinproject
end
