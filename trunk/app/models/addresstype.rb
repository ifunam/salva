class Addresstype < ActiveRecord::Base
  validates_presence_of :name
  has_many :addresses
end
