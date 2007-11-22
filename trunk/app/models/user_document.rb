class UserDocument < ActiveRecord::Base
  validates_presence_of :document_id, :file, :filename, :content_type, :ip_address
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :document_id, :greater_than => 0, :only_integer => true

  validates_numericality_of :user_incharge_id,  :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :document_id, :scope => [ :user_id]
  validates_inclusion_of :status, :in => [true, false]

  belongs_to :document
  belongs_to :user
end
