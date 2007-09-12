class UserSkill < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :skilltype_id, :allow_nil => true, :only_integer => true
  validates_presence_of :skilltype_id, :user_id

  belongs_to :skilltype
end
