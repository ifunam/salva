class Bookedition < ActiveRecord::Base
#  validates_presence_of :book_id, :message => "Proporcione el book_id"
  validates_presence_of :edition_id, :message => "Proporcione el edition_id"
  validates_presence_of :publisher_id, :message => "Proporcione el publisher_id"
  validates_presence_of :mediatype_id, :message => "Proporcione el mediatype_id"
  validates_presence_of :editionstatus_id, :message => "Proporcione el editionstatus_id"

  belongs_to :book
  belongs_to :edition
  belongs_to :publisher 
  belongs_to :mediatype
  belongs_to :editionstatus

  has_and_belongs_to_many :roleinbook, :foreign_key => 'bookedition_id'
  has_and_belongs_to_many :comment, :foreign_key => 'bookedition_id'
end
