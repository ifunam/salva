class Document < ActiveRecord::Base
  validates_presence_of :documenttype_id, :startdate, :enddate
  validates_numericality_of :documenttype_id

  belongs_to :documenttype
end
