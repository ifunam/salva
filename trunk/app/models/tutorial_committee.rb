class TutorialCommittee < ActiveRecord::Base
  validates_presence_of :studentname, :degree_id, :institutioncareer_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :degree_id, :institutioncareer_id, :year, :greater_than => 0, :only_integer => true

  belongs_to :degree
  belongs_to :institutioncareer
  belongs_to :user

  validates_associated :degree
  validates_associated :institutioncareer
end
