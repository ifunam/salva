class ChapterinbookRoleinchapter < ModelComposedKeys
  set_table_name "chapterinbook_roleinchapters"
  set_primary_keys :user_id, :chapterinbook_id
  validates_presence_of :chapterinbook_id, :roleinchapter_id
  validates_numericality_of :chapterinbook_id, :roleinchapter_id
  validates_uniqueness_of :user_id, :scope => [:chapterinbook_id, :roleinchapter_id]

  belongs_to :chapterinbook
  belongs_to :roleinchapter
  attr_accessor :book_id, :bookedition_id
end
