class Projectacadvisit < ActiveRecord::Base
  validates_presence_of :project_id, :acadvisit_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :project_id, :acadvisit_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :acadvisit_id, :scope => [:project_id]

  belongs_to :project
  belongs_to :acadvisit

  validates_associated :project
  validates_associated :acadvisit
end
