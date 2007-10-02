class Document < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :documenttype_id, :title, :startdate, :enddate
  validates_numericality_of :documenttype_id, :allow_nil => false, :only_integer => true
  validates_uniqueness_of  :documenttype_id, :scope => [:documenttype_id, :title]
  belongs_to :documenttype

  has_many :user_documents
  has_many :users, :through => :user_documents
end
