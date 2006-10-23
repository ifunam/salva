class Schooling < ActiveRecord::Base
  attr_accessor :degree_id

  validates_presence_of :institutioncareer_id, :startyear
  validates_numericality_of :institutioncareer_id

  belongs_to :institutioncareer
end
