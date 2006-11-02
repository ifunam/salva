class UserResearchline < ActiveRecord::Base
  attr_accessor :researcharea_id
  validates_presence_of :researchline_id
  validates_numericality_of :researchline_id
  belongs_to :researchline
end
