class Secretquestion < ActiveRecord::Base
  validates_length_of :name, :message => "La pregunta debe contener de 1 a 80 caracteres", :within => 1..80
  validates_uniqueness_of :name, :message => "La pregunta ya existe"
end
