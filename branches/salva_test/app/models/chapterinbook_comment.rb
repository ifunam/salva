class ChapterinbookComment < ActiveRecord::Base
  validates_presence_of :user_id, :message => "Proporcione el user_id"
  validates_presence_of :chapterinbook_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :chapterinbook_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:chapterinbook_id]

  belongs_to :chapterinbook
  belongs_to :user
end
