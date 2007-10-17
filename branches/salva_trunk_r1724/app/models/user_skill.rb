class UserSkill < ActiveRecord::Base
  validates_presence_of :skilltype_id
  validates_numericality_of :skilltype_id

  belongs_to :skilltype
end
