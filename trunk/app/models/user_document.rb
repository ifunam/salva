class UserDocument < ActiveRecord::Base
  validates_presence_of :document_id, :status,  :ip_address
  validates_numericality_of :document_id
  validates_inclusion_of :status, :in=> [true, false]
  validates_uniqueness_of :user_id, :scope => [:user_id, :document_id]
  belongs_to :document
  belongs_to :user
end
