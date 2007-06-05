class Country < ActiveRecord::Base
  validates_numericality_of :id, :only_integer => true 
  validates_inclusion_of :id, :in => 1..999

  validates_length_of :code, :within => 2..3
  validates_format_of :code, :with => /^[a-zA-Z]$/   

  validates_length_of :name, :within => 3..80 
  validates_format_of :name, :with => /^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]$/ 

  validates_length_of :citizen, :within => 3..80 
  validates_format_of :citizen, :with => /^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]$/ 

  validates_presence_of :id, :name, :citizen, :code
  validates_uniqueness_of :name, :citizen, :code, :id

  has_many :state
end
