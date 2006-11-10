class Bookedition < ActiveRecord::Base
  validates_presence_of :edition_id, :message => "Proporcione el edition_id"
  validates_presence_of :publisher_id, :message => "Proporcione el publisher_id"
  validates_presence_of :mediatype_id, :message => "Proporcione el mediatype_id"
  belongs_to :book
  belongs_to :edition
  belongs_to :publisher 
  belongs_to :mediatype
  belongs_to :editionstatus
  has_many :bookedition_roleinbook
  has_many :bookedition_comment
end
