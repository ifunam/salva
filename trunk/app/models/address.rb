class Address < ActiveRecord::Base
  validates_presence_of :country_id, :location
  validates_numericality_of :country_id, :addresstype_id
  validates_inclusion_of :is_postaddress, :in=> [true, false]
  belongs_to :country
  belongs_to :addresstype
  belongs_to :city
  belongs_to :state
  
  attr_accessor :name, :code
end
