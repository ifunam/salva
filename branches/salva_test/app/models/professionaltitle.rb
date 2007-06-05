class Professionaltitle < ActiveRecord::Base
  validates_presence_of :schooling_id, :titlemodality_id
  validates_numericality_of :schooling_id, :titlemodality_id
  belongs_to :schooling
  belongs_to :titlemodality
end
