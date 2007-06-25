class Prize < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
#    validates_numericality_of :prizetype_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :prizetype_id,  :only_integer => true
 #   validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true

  validates_numericality_of :institution_id,  :only_integer => true

  validates_presence_of :name, :prizetype_id, :institution_id
  validates_uniqueness_of :name, :scope => [:institution_id]

  belongs_to :prizetype
  belongs_to :institution

  validates_associated :prizetype, :on => :update
  validates_associated :institution, :on => :update
end
