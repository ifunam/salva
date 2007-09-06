class Projectresearchline < ActiveRecord::Base
  validates_presence_of :project_id, :researchline_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :project_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :researchline_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :project_id, :scope => [:researchline_id]

  belongs_to :project
  belongs_to :researchline
end
