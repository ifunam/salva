 class Prize < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true,  :greater_than =>0, :only_integer => true
  validates_numericality_of :prizetype_id, :institution_id,  :greater_than =>0, :only_integer => true


  validates_presence_of :name, :prizetype_id, :institution_id
  validates_uniqueness_of :name, :scope => [:institution_id]

  belongs_to :prizetype
  belongs_to :institution

  validates_associated :prizetype
  validates_associated :institution
end
