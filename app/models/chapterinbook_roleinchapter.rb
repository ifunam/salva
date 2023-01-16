class ChapterinbookRoleinchapter < ActiveRecord::Base
  # attr_accessor :user_id, :roleinchapter_id, :chapterinbook_id
  validates_presence_of  :roleinchapter_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :roleinchapter_id, :user_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :chapterinbook
  belongs_to :roleinchapter
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :bookeditions

  scope :published, -> { joins(:chapterinbook).where("bookeditions.editionstatus_id = 1") }
  scope :authors, -> { where("roleinchapter_id = 1 OR roleinchapter_id = 2") }
  scope :collaborators, -> { where("roleinchapter_id != 1 AND roleinchapter_id != 2") }
  scope :find_by_year, lambda { |year|
    bookedition_sql = Bookedition.select('id').since(year,1).until(year,12).to_sql
    sql = "chapterinbooks.bookedition_id IN (#{bookedition_sql})"
    joins(:chapterinbook=>:bookedition).where(sql)
  }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :find_by_year, :adscription_id

  def to_s
    "#{user.author_name} (#{roleinchapter.name})"
  end
end
