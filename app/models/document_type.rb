class DocumentType < ActiveRecord::Base
  validates_presence_of :name
  # attr_accessor :name
  validates_uniqueness_of :name
  has_many :documents
  has_many :reports
  default_scope -> { order(name: :asc) }
end
