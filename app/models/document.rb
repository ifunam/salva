class Document < ActiveRecord::Base
  # FIXIT: Remove not null constraints for :documenttype_id, :title, :startdate, :enddate
  validates_presence_of :document_type_id

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :document_type_id, :greater_than => 0, :only_integer => true

  belongs_to :document_type
  belongs_to :user
  mount_uploader :file, DocumentUploader

  # FIXIT: Remove documenttype reference
  belongs_to :documenttype
  validates_associated :documenttype

  # FIXIT: Remove user_documents and users references
  has_many :user_documents
  has_many :users, :through => :user_documents
end
