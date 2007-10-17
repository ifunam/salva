class Chapterinbook < ActiveRecord::Base
  validates_presence_of :bookedition_id, :bookchaptertype_id, :title
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :bookedition_id,  :bookchaptertype_id, :greater_than => 0, :only_integer => true

  validates_uniqueness_of :title, :scope => [:bookedition_id, :bookchaptertype_id]

  belongs_to :bookedition
  belongs_to :bookchaptertype

  has_many :projectchapterinbooks
  has_many :chapterinbook_comments

  validates_associated :bookedition
  validates_associated :bookchaptertype
end
