class Book < ActiveRecord::Base
  has_and_belongs_to_many :user
  validates_presence_of :title, :message => "Idiota, olvidaste el mensaje"
  validates_presence_of :author, :message => "Pendejo, olvidaste el autor"
end
