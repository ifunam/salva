class Career < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :degree_id, :only_integer => true

  validates_length_of :name, :within => 3..500
  validates_presence_of :name, :degree_id
  validates_uniqueness_of :name, :scope => [:degree_id]

  belongs_to :degree
  validates_associated :degree, :on => :update
end
