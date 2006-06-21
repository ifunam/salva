class Group < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :within => 3..100
  validates_uniqueness_of :name
end
