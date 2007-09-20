class Schooling < ActiveRecord::Base
  validates_presence_of :institutioncareer_id, :startyear
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institutioncareer_id, :startyear, :only_integer => true
  validates_numericality_of :endyear, :credits, :allow_nil => true
  validates_uniqueness_of :user_id, :institutioncareer_id

  belongs_to :institutioncareer
  has_many :professionaltitles
end
