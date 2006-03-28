class Address < ActiveRecord::Base
  validates_presence_of :country_id, :addresstype_id, :is_postaddress, :addr
  validates_numericality_of :country_id, :addresstype_id, :state_id, :zipcode
  
  belongs_to :country
  belongs_to :addresstype
  belongs_to :city
  belongs_to :state
end

