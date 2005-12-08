class Personal < ActiveRecord::Base
  set_primary_key "user_id"
  validates_format_of  :photo_content_type,  :with => /^image/, :message => "Bestia peluda, solamente debe subir imágenes"

 # before_create :prepare_new_record
  
 # def prepare_new_record
#  def photo=(photo_field) 
#
#    name = base_part_of(photo_field.original_filename)
#    content_type = photo_field.content_type.chomp
#    photo = photo_field.read
#    self.photo = photo


#    logger.info "FILE:"+content_type.to_s
#    logger.info "FILE:"+photo.to_s
#    self.photo = photo
#  end

 
end
