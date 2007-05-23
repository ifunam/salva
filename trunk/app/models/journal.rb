class Journal < ActiveRecord::Base
validates_numericality_of :id, :allow_nil => true, :only_integer => true
validates_numericality_of :mediatype_id, :allow_nil => true, :only_integer => true
validates_numericality_of :country_id, :allow_nil => true, :only_integer => true
validates_numericality_of :publisher_id, :allow_nil => true, :only_integer => true
validates_presence_of :name, :mediatype_id, :country_id
validates_length_of :name, :within => 1..500
validates_format_of :issn, :with => /^([0-9]{4}-[0-9]{3}[0-9X])?$/
validates_uniqueness_of :name, :scope => [:issn, :country_id, :mediatype_id]
validates_associated :country, :on => :update
validates_associated :publisher, :on => :update
validates_associated :mediatype, :on => :update
belongs_to :mediatype
belongs_to :publisher
belongs_to :country
end
