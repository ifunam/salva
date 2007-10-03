class Externaluser < ActiveRecord::Base
  validates_presence_of :firstname, :lastname1
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :externaluserlevel_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :degree_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :lastname1, :scope => [ :firstname,  :lastname2]

  belongs_to :institution
  belongs_to :externaluserlevel
  belongs_to :degree
end
