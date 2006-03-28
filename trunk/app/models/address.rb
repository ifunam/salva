class Address < ActiveRecord::Base
<!--[salva_model:]-->
validates_presence_of :city, :country_id, :addresstype_id, :is_postaddress, :address

validates_numericality_of :country_id, :addresstype_id, :state_id

belongs_to :country

belongs_to :addresstype

belongs_to :state


<!--[eof_salva_model:]-->

end

