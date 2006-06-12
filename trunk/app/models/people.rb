class Person < ActiveRecord::Base
  set_primary_key "user_id"
  
  attr_protected :id, :moduser_id, :created_on, :updated_on

  validates_presence_of :firstname,  :lastname1, 
  :dateofbirth, :birth_country_id, :birth_state_id, :birth_city, 
  :maritalstatus_id
  validates_numericality_of :birth_country_id, :birth_state_id, 
  :maritalstatus_id
  validates_inclusion_of :gender, :in=>%w( t f ), 
  :message=>"woah! what are you then!??!!"

  belongs_to :birth_country,
  :class_name => 'Country',
  :foreign_key => 'birth_country_id'
  belongs_to :birth_state,
  :class_name => 'State',
  :foreign_key => 'birth_state_id'
  belongs_to :birth_city,
  :class_name => 'City',
  :foreign_key => 'birth_city_id'
  belongs_to :maritalstatus
  
 
  attr_accessor :name, :code, :country_id, :state_id
end
