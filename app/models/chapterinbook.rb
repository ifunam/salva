class Chapterinbook < ActiveRecord::Base
  validates_presence_of :bookchaptertype_id, :title
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :bookchaptertype_id, :greater_than => 0, :only_integer => true

  belongs_to :bookedition
  belongs_to :bookchaptertype
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  has_many :projectchapterinbooks
  has_many :chapterinbook_comments
end
