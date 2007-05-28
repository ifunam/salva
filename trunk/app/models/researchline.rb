class Researchline < ActiveRecord::Base
validates_presence_of :name
validates_uniqueness_of :name
validates_length_of :name, :within => 1..500
validates_numericality_of :id, :allow_nil => true, :only_integer => true
validates_numericality_of :researcharea_id, :allow_nil => true, :only_integer => true
belongs_to :researcharea
end
