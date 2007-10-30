class Externaluser < ActiveRecord::Base
  validates_presence_of :firstname, :lastname1
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :externaluserlevel_id, :degree_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :institution
  belongs_to :externaluserlevel
  belongs_to :degree

  validates_associated :institution
  validates_associated :externaluserlevel
  validates_associated :degree
end
