class UserProceeding < ActiveRecord::Base
  validates_presence_of :proceeding_id, :roleproceeding_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :proceeding_id, :roleproceeding_id, :greater_than => 0, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:proceeding_id, :roleproceeding_id]

  belongs_to :user
  belongs_to :proceeding
  belongs_to :roleproceeding

  validates_associated :user
  validates_associated :proceeding
  validates_associated :roleproceeding
end
