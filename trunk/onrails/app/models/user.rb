class User < ActiveRecord::Base
  set_table_name 'users'
  belongs_to :secretquestion
  belongs_to :userstatus

  validates_presence_of :login, :message => 'Debe especificar un login'
  validates_presence_of :passwd, :message => 'Debe especificar una contraseña'
  validates_uniqueness_of :login, :message => 'Ya existe un usuario con el login especificado'

  def self.per_pages
    10
  end

  def self.order_by
    'id'
  end

  def self.update_msg
    'El usuario ha sido modificado'
  end

  def self.destroy_msg
    'El usuario ha sido eliminado'
  end

  def self.create_msg
    'El usuario ha sido creado'
  end
end
