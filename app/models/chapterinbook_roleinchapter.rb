class ChapterinbookRoleinchapter < ActiveRecord::Base
  validates_presence_of  :roleinchapter_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :roleinchapter_id, :user_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :chapterinbook
  belongs_to :roleinchapter
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :bookeditions

  def as_text
    "#{user.author_name} (#{roleinchapter.name})"
  end
  
end
