class UserResearchline < ActiveRecord::Base
  validates_presence_of :researchline_id, :user_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :researchline_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_uniqueness_of :id
 
  belongs_to :researchline
  belongs_to :user

end
