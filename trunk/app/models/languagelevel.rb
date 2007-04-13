class Languagelevel < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :within => 1..40
  validates_uniqueness_of :name
end
