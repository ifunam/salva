class UserDocument < ActiveRecord::Base
  validates_presence_of :document_id, :is_published, :date_published, :document, :filename, :content_type, :ip_address
  validates_numericality_of :document_id
  validates_uniqueness_of :user_id, :scope => [:document_id]

  belongs_to :document
  belongs_to :user
end
