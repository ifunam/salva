class Projectfinancingsource < ActiveRecord::Base
  # attr_accessor :institution_id

  validates_presence_of :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  #validates_numericality_of :project_id, :institution_id,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :project_id, :scope => [:institution_id]

  belongs_to :project
  belongs_to :institution

  validates_associated :project
  validates_associated :institution
end
