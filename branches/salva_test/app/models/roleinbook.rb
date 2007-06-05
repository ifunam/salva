class Roleinbook < ActiveRecord::Base
  validates_presence_of :name, :message => 'El rol del usuario es obligatorio'
  has_and_belongs_to_many :bookedition
end
