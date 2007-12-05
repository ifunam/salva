class ChapterinbookRoleinchapter < ActiveRecord::Base
  validates_presence_of :chapterinbook_id, :roleinchapter_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :chapterinbook_id, :roleinchapter_id, :user_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:chapterinbook_id, :roleinchapter_id]

  belongs_to :user
  belongs_to :chapterinbook
  belongs_to :roleinchapter
  has_many :bookeditions

  validates_associated :chapterinbook
  validates_associated :roleinchapter
end
