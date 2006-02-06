class Bookedition < ActiveRecord::Base
  belongs_to :book
  belongs_to :edition
  belongs_to :publisher
  belongs_to :mediatype
  belongs_to :editionstatus

  has_and_belongs_to_many :roleinbook
end
