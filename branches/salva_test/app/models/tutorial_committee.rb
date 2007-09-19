class TutorialCommittee < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institutioncareer_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :degree_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :year, :allow_nil => true, :only_integer => true
   validates_presence_of :studentname, :degree_id, :institutioncareer_id, :year, :user_id

   belongs_to :degree
   belongs_to :institutioncareer
end
