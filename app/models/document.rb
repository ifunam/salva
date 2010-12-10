class Document < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :documenttype
  belongs_to :approved_by, :class_name => 'User'

  #mount_uploader :file, DocumentUploader
end
