class UserResearchline < ActiveRecord::Base
  validates_presence_of :researchline_id, :user_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :researchline_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:researchline_id]

  belongs_to :researchline
  belongs_to :user
end
