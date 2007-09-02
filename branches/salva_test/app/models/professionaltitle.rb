class Professionaltitle < ActiveRecord::Base
  validates_presence_of :schooling_id, :titlemodality_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :schooling_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :titlemodality_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :schooling_id, :scope => [:titlemodality_id]

  belongs_to :schooling
  belongs_to :titlemodality
end
