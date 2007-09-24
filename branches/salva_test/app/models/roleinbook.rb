class Roleinbook < ActiveRecord::Base
  validates_presence_of :name, :message => 'El rol del usuario es obligatorio'
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_uniqueness_of :name

  has_many :bookedition_roleinbooks
end
