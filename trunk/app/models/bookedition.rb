class Bookedition < ActiveRecord::Base
  validates_presence_of :edition_id, :mediatype_id, :year
  validates_uniqueness_of :edition_id, :scope => [ :book_id, :mediatype_id ]

  belongs_to :book
  belongs_to :edition
  belongs_to :publisher
  belongs_to :mediatype
  belongs_to :editionstatus

  has_many :bookedition_comment
  has_many :chapterinbook
end
