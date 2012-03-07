class Image < ActiveRecord::Base
  attr_accessible :file
  mount_uploader :file, ImageUploader
  belongs_to :imageable, :polymorphic => true
end
