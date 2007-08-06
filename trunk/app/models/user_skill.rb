class UserSkill < ActiveRecord::Base
  attr_accessor :name 

  validates_presence_of :skilltype_id
  validates_numericality_of :skilltype_id

  belongs_to :skilltype
end
