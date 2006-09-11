class Person < ActiveRecord::Base
  set_primary_key "user_id"
  
  validates_presence_of :firstname,  :lastname1, :dateofbirth, :maritalstatus_id, :country_id, :state_id, :city
  validates_numericality_of :country_id, :state_id, :maritalstatus_id
  #validates_inclusion_of :gender, :in=> %w(f t),  :message=>"woah! what are you then!??!!"
  
  belongs_to :maritalstatus
  belongs_to :country
  belongs_to :state
  belongs_to :city

  attr_accessor :name, :code
end
