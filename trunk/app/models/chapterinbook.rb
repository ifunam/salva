class Chapterinbook < ActiveRecord::Base
  validates_presence_of :bookedition_id, :chapter
  validates_numericality_of :bookedition_id
  belongs_to :bookedition
end
