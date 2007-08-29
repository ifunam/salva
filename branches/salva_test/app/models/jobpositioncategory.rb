class Jobpositioncategory < ActiveRecord::Base
  validates_presence_of :jobpositiontype_id, :roleinjobposition_id, :jobpositionlevel_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :jobpositiontype_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :roleinjobposition_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :jobpositionlevel_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :jobpositiontype_id, :scope => [:roleinjobposition_id]

  belongs_to :jobpositiontype
  belongs_to :roleinjobposition
  belongs_to :jobpositionlevel
end
