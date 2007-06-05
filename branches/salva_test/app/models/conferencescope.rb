class Conferencescope < ActiveRecord::Base
validates_presence_of :id
validates_numericality_of :id, :allow_nil => true, :only_integer => true
validates_inclusion_of:id, :in => 1..200
validates_uniqueness_of :id
validates_presence_of :name
validates_uniqueness_of :name
end
