class Bookedition < ActiveRecord::Base

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :edition_id, :book_id, :mediatype_id, :edition_id, :greater_than =>0, :only_integer => true
  validates_numericality_of :publisher_id, :editionstatus_id, :allow_nil => true, :greater_than => 0, :only_integer =>true

  validates_presence_of :edition_id
  validates_presence_of :mediatype_id
  validates_uniqueness_of :edition_id, :scope => [ :book_id, :mediatype_id ]

  belongs_to :book
  belongs_to :edition
  belongs_to :mediatype
  belongs_to :editionstatus
  belongs_to :publisher

  has_many :bookedition_comments
  has_many :chapterinbooks
  has_many :bookedition_publishers
  has_many :bookedition_roleinbooks

  validates_associated :publisher
  validates_associated :edition
  validates_associated :mediatype
  validates_associated :editionstatus
   validates_associated :book
end
