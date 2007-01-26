class Institutiontitle < ActiveRecord::Base
  validates_presence_of :name
  has_many :institution
end

