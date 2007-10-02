class Stimuluslevel < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :stimulustype_id, :only_integer => true
  validates_presence_of :name, :stimulustype_id
  validates_uniqueness_of :name

  belongs_to :stimulustype

end
