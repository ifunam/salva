class Coursegroup < ActiveRecord::Base
validates_presence_of :name, :coursegrouptype_id, :startyear
validates_numericality_of :coursegrouptype_id,:allow_nil => true, :only_integer => true
validates_numericality_of :id, :allow_nil => true, :only_integer => true
validates_uniqueness_of :name, :scope => [:startyear]
validates_length_of :name, :within => 1..50

belongs_to :coursegrouptype
validates_associated :projecttype, :on => :update

end
