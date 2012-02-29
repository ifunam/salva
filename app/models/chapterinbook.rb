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

  default_scope :order => 'title ASC'
  scope :recent, :order => 'bookeditions.year DESC, bookeditions.month DESC', :include => :bookedition, :limit => 20
  scope :published, :conditions => 'bookeditions.editionstatus_id = 1', :include => :bookedition
  scope :inprogress, :conditions => 'bookeditions.editionstatus_id != 1', :include => :bookedition

  scope :user_id_eq, lambda { |user_id|
    joins(:chapterinbook_roleinchapters).
    where(:chapterinbook_roleinchapters => { :user_id => user_id })
  }

  scope :user_id_not_eq, lambda { |user_id|
      where("chapterinbooks.id IN (#{ChapterinbookRoleinchapter.select('DISTINCT(chapterinbook_id) as chapterinbook_id').
      where(["chapterinbook_roleinchapters.user_id != ?", user_id]).to_sql}) AND chapterinbooks.id  NOT IN (#{ChapterinbookRoleinchapter.select('DISTINCT(chapterinbook_id) as chapterinbook_id').
      where(["chapterinbook_roleinchapters.user_id = ?", user_id]).to_sql})")
  }

  # FIX IT
  scope :since, lambda { |year, month| where("chapterinbooks.bookedition_id IN (#{Bookedition.select('id').since(year,month).to_sql})") }
  scope :until, lambda { |year, month| where("chapterinbooks.bookedition_id IN (#{Bookedition.select('id').until(year,month).to_sql})") }

  search_methods :user_id_eq, :user_id_not_eq
  search_methods :since, :splat_param => true, :type => [:integer, :integer]
  search_methods :until, :splat_param => true, :type => [:integer, :integer]

  def as_text
    [bookchaptertype.name, title].join(': ') + '. ' + bookedition.as_text
  end
end
