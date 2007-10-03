class Projectfinancingsource < ActiveRecord::Base
  validates_presence_of :project_id, :institution_id, :amount
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :project_id, :institution_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :project_id, :scope => [:institution_id]

  belongs_to :project
  belongs_to :institution

  validates_associated :project
  validates_associated :institution
end
