class Userstatus < ActiveRecord::Base
  validates_length_of :name, :within => 1..20, :message => 'El estado de usuario debe contener de 1 a 20 caracteres'
  validates_uniqueness_of :name, :message => 'El estado ya existe'

  def self.per_pages
    10
  end

  def self.order_by
    'name'
  end

  def self.create_msg
    'El nuevo estado ha sido agregado'
  end

  def self.destroy_msg
    'El estado ha sido borrado'
  end

  def self.update_msg
    'El estado ha sido actualizado'
  end
end
