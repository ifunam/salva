class Language < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :name
  validates_length_of :name, :within => 3..200

  validates_format_of :name, :with => /^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]$/ 

  validates_uniqueness_of :name
end
