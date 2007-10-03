class UserSkill < ActiveRecord::Base
  validates_presence_of :skilltype_id, :user_id
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :skilltype_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :skilltype
end
