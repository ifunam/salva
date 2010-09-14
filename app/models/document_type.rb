class DocumentType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :documents
  default_scope :order => 'name ASC'
end
