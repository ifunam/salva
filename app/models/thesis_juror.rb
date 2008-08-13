class ThesisJuror < ActiveRecord::Base
  validates_presence_of :roleinjury_id, :year
  validates_numericality_of :roleinjury_id, :year
  belongs_to :user
  belongs_to :thesis
  belongs_to :roleinjury
end
