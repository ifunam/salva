class Document < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :documenttype
  #mount_uploader :file, DocumentUploader

  # FIXIT: Remove user_documents and users references
  has_many :user_documents
  has_many :users, :through => :user_documents
end
