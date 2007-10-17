class UserProceeding < ActiveRecord::Base
  validates_presence_of :proceeding_id, :roleproceeding_id
  validates_numericality_of :proceeding_id, :roleproceeding_id
  validates_uniqueness_of :user_id, :scope => [:proceeding_id, :roleproceeding_id]
  belongs_to :user
  belongs_to :proceeding
  belongs_to :roleproceeding
end
