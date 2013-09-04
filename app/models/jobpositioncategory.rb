class Jobpositioncategory < ActiveRecord::Base
  attr_accessible :jobpositiontype_id, :roleinjobposition_id
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


  # scope :find_by_jobpositiontype_id,  where("jobpositioncategories.jobpositiontype_id = 1").order('roleinjobpositions.name ASC, jobpositionlevels.name ASC')
  default_scope includes(:roleinjobposition, :jobpositionlevel).order('roleinjobpositions.name ASC, jobpositionlevels.name ASC')
  scope :for_researching, where("jobpositioncategories.jobpositiontype_id = 1 OR jobpositioncategories.roleinjobposition_id = 38 OR jobpositioncategories.roleinjobposition_id = 110 OR jobpositioncategories.roleinjobposition_id = 112")
  def name
    unless self.new_record?
      [(roleinjobposition.nil? ? nil : roleinjobposition.name), (self.jobpositionlevel_id.nil? ? nil : jobpositionlevel.name) ].compact.join(' ')
    else
      ""
    end
  end
end
