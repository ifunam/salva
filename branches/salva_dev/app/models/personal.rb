class Personal < ActiveRecord::Base
  set_primary_key "user_id"
  
  validates_presence_of :firstname,  :lastname1, :sex,
  :dateofbirth, :birth_country_id, :birth_state_id, :birthcity, 
  :maritalstatus_id, :message => 'wey, estos campos son obligatorios'
  validates_numericality_of :birth_country_id, :birth_state_id, 
  :maritalstatus_id
 validates_inclusion_of :sex, :in=> ['true', 'false'], :message=>"wow! Entonces qué pinche genero tienes? pinche indeciso ;)!..."
#  validates_format_of  :photo_content_type,  :with => /^image/
end
