class UserDocument < ActiveRecord::Base
  validates_presence_of :document_id, :ip_address
  validates_numericality_of :document_id
  validates_uniqueness_of :user_id, :scope => [:user_id, :document_id]
  belongs_to :document
  belongs_to :user
end
