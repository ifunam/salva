class Indivadviceprogram < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
  validates_presence_of :name
  validates_uniqueness_of :name
  belongs_to :institution
end
