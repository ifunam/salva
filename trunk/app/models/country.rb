class Country < ActiveRecord::Base
  has_many :states
  has_many :journals
  has_many :newspapers
  has_many :acadvisits
  has_many :courses

  validates_numericality_of :id, :allow_nil => true, :only_integer => true

  validates_format_of :code, :with => /^[a-zA-Z]$/
  validates_format_of :name, :with => /^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]$/
  validates_format_of :citizen, :with => /^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]$/

  validates_presence_of  :name, :citizen, :code
  validates_uniqueness_of :name, :citizen, :code
end
