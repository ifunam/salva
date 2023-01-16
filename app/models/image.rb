class Image < ActiveRecord::Base
  # attr_accessor :file
  mount_uploader :file, ImageUploader
  belongs_to :imageable, :polymorphic => true
end
