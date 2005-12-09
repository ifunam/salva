class Personal < ActiveRecord::Base
  set_primary_key "user_id"
#  validates_format_of  :photo_content_type,  :with => /^image/, :message => "Bestia peluda, solamente debe subir imágenes"
 
end
