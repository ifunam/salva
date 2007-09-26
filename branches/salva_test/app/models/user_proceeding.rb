class UserProceeding < ActiveRecord::Base
  validates_presence_of :proceeding_id, :roleproceeding_id, :user_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :proceeding_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :roleproceeding_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:proceeding_id, :roleproceeding_id]

  belongs_to :user
  belongs_to :proceeding
  belongs_to :roleproceeding
end
