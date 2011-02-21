class TutorialCommittee < ActiveRecord::Base
  validates_presence_of :studentname, :degree_id,  :year
  validates_numericality_of :id, :user_id, :institutioncareer_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :degree_id,  :year, :greater_than => 0, :only_integer => true

  belongs_to :degree
  belongs_to :institutioncareer
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'
end
