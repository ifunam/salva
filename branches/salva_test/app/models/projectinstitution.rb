class Projectinstitution < ActiveRecord::Base
  validates_presence_of :project_id, :institution_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :project_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :project_id, :scope => [:institution_id]

  belongs_to :project
  belongs_to :institution
end
