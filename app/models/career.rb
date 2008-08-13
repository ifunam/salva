class Career < ActiveRecord::Base
  validates_presence_of :name, :degree_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :degree_id, :greater_than => 0, :only_integer => true

  belongs_to :degree
  validates_associated :degree
end
