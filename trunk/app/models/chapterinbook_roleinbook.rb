class ChapterinbookRoleinbook < ModelComposedKeys
  set_table_name "chapterinbook_roleinbooks"
  set_primary_keys :user_id, :chapterinbook_id
  validates_presence_of :chapterinbook_id, :roleinbook_id
  validates_numericality_of :chapterinbook_id, :roleinbook_id
  belongs_to :chapterinbook
  belongs_to :roleinbook
  attr_accessor :book_id, :bookedition_id
end
