 class Projectgenericwork < ActiveRecord::Base
  validates_presence_of :project_id, :genericwork_id

  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :project_id, :genericwork_id, :greater_than => 0, :only_integer => true

  validates_uniqueness_of :project_id, :scope => [:genericwork_id]

  belongs_to :project
  belongs_to :genericwork
  validates_associated :project
  validates_associated :genericwork
 end
