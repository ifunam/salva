class Document < ActiveRecord::Base
  validates_presence_of :documenttype_id, :title, :startdate, :enddate
  validates_numericality_of :documenttype_id
  validates_uniqueness_of  :title, :scope => [:documenttype_id, :title]
  belongs_to :documenttype

  has_many :user_documents
  has_many :users, :through => :user_documents
end
