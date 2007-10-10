class Projectthesis < ActiveRecord::Base
  validates_presence_of :project_id, :thesis_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :project_id, :thesis_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :project_id, :scope => [:thesis_id]

  belongs_to :project
  belongs_to :thesis

   validates_associated :project
   validates_associated :thesis
end
