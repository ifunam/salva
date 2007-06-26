class Userconference < ActiveRecord::Base
  validates_presence_of :conference_id, :roleinconference_id
  validates_numericality_of :conference_id, :roleinconference_id
  validates_uniqueness_of :user_id, :scope => [:conference_id, :roleinconference_id]
  belongs_to :conference
  belongs_to :roleinconference
end
