class Personal < ActiveRecord::Base
  set_primary_key "user_id"
  validates_format_of  :content_type,  :with => /^image/, :message => "Usted solamente debe subir imágenes"

 # before_create :prepare_new_record
  
 # def prepare_new_record
    #  def photo=(photo) 
    #self.name = base_part_of(photo_field.original_filename)
    #self.content_type = photo_field.content_type.chomp
#    self.photo = 
  # end

# def base_part_of(file_name)
#  name = File.basename(file_name)
#  name.gsub(/[^\w._-]/, ' ' )
# end
end
