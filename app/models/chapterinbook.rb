class Chapterinbook < ActiveRecord::Base
  validates_presence_of :bookchaptertype_id, :title
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :bookchaptertype_id, :greater_than => 0, :only_integer => true

  belongs_to :bookedition
  belongs_to :bookchaptertype
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  accepts_nested_attributes_for :bookedition

  has_many :chapterinbook_roleinchapters
  has_many :users, :through => :chapterinbook_roleinchapters
  accepts_nested_attributes_for :chapterinbook_roleinchapters
  user_association_methods_for :chapterinbook_roleinchapters
  has_paper_trail

  scope :user_id_eq, lambda { |user_id|
    joins(:chapterinbook_roleinchapters).
    where(:chapterinbook_roleinchapters => { :user_id => user_id })
  }

  scope :user_id_not_eq, lambda { |user_id|
      where("chapterinbooks.id IN (#{ChapterinbookRoleinchapter.select('DISTINCT(chapterinbook_id) as chapterinbook_id').
      where(["chapterinbook_roleinchapters.user_id != ?", user_id]).to_sql}) AND chapterinbooks.id  NOT IN (#{ChapterinbookRoleinchapter.select('DISTINCT(chapterinbook_id) as chapterinbook_id').
      where(["chapterinbook_roleinchapters.user_id = ?", user_id]).to_sql})")
  }
  search_methods :user_id_eq, :user_id_not_eq

  default_scope :order => 'title ASC'

  def as_text
    [bookchaptertype.name, title].join(': ') + '. ' + bookedition.as_text
  end
end
