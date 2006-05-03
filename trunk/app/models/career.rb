class Career < ActiveRecord::Base
  validates_presence_of :name
  has_many :schoolings, :dependent => true
end
