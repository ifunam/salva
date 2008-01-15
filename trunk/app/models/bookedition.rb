class Bookedition < ActiveRecord::Base

  validates_presence_of :edition, :mediatype_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of  :mediatype_id,  :greater_than => 0, :only_integer => true
  validates_numericality_of :editionstatus_id, :allow_nil => true, :greater_than => 0, :only_integer =>true


  #validates_uniqueness_of :edition, :scope => [ :book_id, :mediatype_id ]

  belongs_to :book
  belongs_to :mediatype
  belongs_to :editionstatus

  has_many :bookedition_comments
  has_many :chapterinbooks
  has_many :bookedition_publishers
  has_many :bookedition_roleinbooks
  
  #validates_associated :mediatype
  #validates_associated :editionstatus
end
