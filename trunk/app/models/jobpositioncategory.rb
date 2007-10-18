class Jobpositioncategory < ActiveRecord::Base
  validates_presence_of :jobpositiontype_id, :roleinjobposition_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :jobpositiontype_id, :roleinjobposition_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :jobpositionlevel_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :jobpositiontype_id, :scope =>[:jobpositionlevel_id, :roleinjobposition_id]

  belongs_to :jobpositiontype
  belongs_to :roleinjobposition
  belongs_to :jobpositionlevel

  validates_associated :jobpositiontype
  validates_associated :roleinjobposition
  validates_associated :jobpositionlevel
end
