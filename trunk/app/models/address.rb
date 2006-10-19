class Address < ActiveRecord::Base
  validates_presence_of :country_id, :is_postaddress, :addr
  validates_numericality_of :country_id, :addresstype_id
  
  belongs_to :country
  belongs_to :addresstype
  belongs_to :city
  belongs_to :state
  
  attr_accessor :name, :code
end
