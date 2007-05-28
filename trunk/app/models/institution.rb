class Institution < ActiveRecord::Base
validates_numericality_of :id, :allow_nil => true, :only_integer => true
validates_numericality_of :institutiontitle_id, :allow_nil => true, :only_integer => true
validates_numericality_of :institutiontype_id, :allow_nil => true, :only_integer => true
validates_numericality_of :country_id, :allow_nil => true, :only_integer => true
validates_presence_of :name, :institutiontitle_id, :institutiontype_id, :country_id
validates_length_of :name, :within => 2..300
validates_uniqueness_of :name, :scope => [:country_id, :state_id]
validates_associated :institution_id, :on => :update
validates_associated :institutiontitle, :on => :update
validates_associated :institutiontype, :on => :update
validates_associated :country, :on => :update
validates_associated :state, :on => :update
validates_associated :city, :on => :update
belongs_to :country
belongs_to :institutiontype
belongs_to :institutiontitle
belongs_to :city
belongs_to :state
belongs_to :institution
end

