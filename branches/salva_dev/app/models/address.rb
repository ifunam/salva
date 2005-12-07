class Address < ActiveRecord::Base
  validates_presence_of :addresstype_id, :message => "Proporcione el tipo de dirección"
  validates_presence_of :country_id, :message => "Proporcione el país"
  validates_presence_of :postaddress, :message => "Proporcione la dirección"
  validates_presence_of :city, :message => 'Proporcione la información de la ciudad'
  validates_presence_of :mail, :message => 'Indique si usara esta dirección como domicilio postal'
end
