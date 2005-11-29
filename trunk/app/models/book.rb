class Book < ActiveRecord::Base
  validates_presence_of :title, :message => "Idiota, olvidaste el mensaje"
  validates_presence_of :author, :message => "Pendejo, olvidaste el autor"
end
