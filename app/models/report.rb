class Report < ActiveRecord::Base
  # attr_accessor :document_type_id, :file
  belongs_to :document_type
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'
  has_many :users

  mount_uploader :file, DocumentUploader
end
