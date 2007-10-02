class Stimulustype < ActiveRecord::Base
  has_many :stimuluslevels
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id,  :only_integer => true
  validates_presence_of :name, :institution_id
  validates_uniqueness_of :name

  belongs_to :institution
end
