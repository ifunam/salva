class Schooling < ActiveRecord::Base
  validates_presence_of :institutioncareer_id, :startyear
  validates_numericality_of :institutioncareer_id, :startyear
  validates_numericality_of :endyear, :credits, :allow_nil => true
  belongs_to :institutioncareer
  has_many :professionaltitles
end
