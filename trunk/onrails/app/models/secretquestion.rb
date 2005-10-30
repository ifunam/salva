class Secretquestion < ActiveRecord::Base
  validates_length_of :name, :message => "La pregunta debe contener de 1 a 80 caracteres", :within => 1..80
  validates_uniqueness_of :name, :message => "La pregunta ya existe"

  def self.per_pages
    10 
  end

  def self.order_by
    'name'
  end

  def self.create_msg
    'La nueva pregunta ha sido agregada'
  end

  def self.destroy_msg
    'La pregunta ha sido borrada'
  end

  def self.update_msg
    'La pregunta ha sido actualizada'
  end
end
