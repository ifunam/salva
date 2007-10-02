class ChapterinbookRoleinchapter < ActiveRecord::Base
  validates_presence_of :chapterinbook_id, :roleinchapter_id
  validates_numericality_of :chapterinbook_id, :roleinchapter_id
  validates_uniqueness_of :user_id, :scope => [:chapterinbook_id, :roleinchapter_id]

  belongs_to :user
  belongs_to :chapterinbook
  belongs_to :roleinchapter
  has_many :bookeditions
end
