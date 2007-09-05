class Bookedition < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :edition_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :book_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :mediatype_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :editionstatus_id, :allow_nil => true, :only_integer => true


  validates_presence_of :edition_id
  validates_presence_of :mediatype_id
  validates_uniqueness_of :edition_id, :scope => [ :book_id, :mediatype_id ]

  belongs_to :book
  belongs_to :edition
  belongs_to :mediatype
  belongs_to :editionstatus

  has_many :bookedition_comments
  has_many :chapterinbooks
  has_many :bookedition_publishers
end
