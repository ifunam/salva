class Group < ActiveRecord::Base
  validates_presence_of :name, :message => 'El nombre del grupo es obligatorio'
end
