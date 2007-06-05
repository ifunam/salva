class Genericworkgroup < ActiveRecord::Base
validates_presence_of :id
validates_numericality_of :id, :only_integer => true 
validates_inclusion_of:id, :in => 1..100 
validates_uniqueness_of :id
validates_presence_of :name
validates_uniqueness_of :name
end
