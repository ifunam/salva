class ChapterinbookRoleinchapter < ActiveRecord::Base
  attr_accessible :user_id, :roleinchapter_id, :chapterinbook_id
  validates_presence_of  :roleinchapter_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :roleinchapter_id, :user_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :chapterinbook
  belongs_to :roleinchapter
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :bookeditions

  scope :find_by_year, lambda { |year|
    bookedition_sql = Bookedition.select('id').since(year,1).until(year,12).to_sql
    sql = "chapterinbooks.bookedition_id IN (#{bookedition_sql})"
    joins(:chapterinbook=>:bookedition).where(sql)
  }

  def to_s
    "#{user.author_name} (#{roleinchapter.name})"
  end
  
end
