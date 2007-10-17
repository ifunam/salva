class ThesisJuror < ActiveRecord::Base
  validates_presence_of :thesis_id, :roleinjury_id, :year
  validates_numericality_of :thesis_id, :roleinjury_id, :user_id
  validates_uniqueness_of :thesis_id, :scope =>[:roleinjury_id, :user_id]
  belongs_to :user
  belongs_to :thesis
  belongs_to :roleinjury
end
