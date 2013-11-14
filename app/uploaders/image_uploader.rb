# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  storage :file
  def extension_white_list
    %w(jpg jpeg gif png bmp tif tiff)
  end
  # FIXME: Check for bugs in url method CarrierWave
  # Don't try it at home!!!
  def url(version=nil)
    if !version.nil? and !@versions.nil? and !@versions[version].nil?
      @versions[version].file.file.sub(/#{Rails.root.to_s}\/public/,'')
    else
      Rails.root.join("public/avatar_missing_icon.png")
    end
  end 
  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fit => [113, 80]

  version :icon do
    process :resize_to_fill => [48, 48]
  end

  version :thumb do
    process :resize_to_fill => [128, 128]
  end

  version :medium do
    process :resize_to_fill => [256, 256]
  end

  version :card do
    process :resize_to_fill => [100, 100]
  end
end
