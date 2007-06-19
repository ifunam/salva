class Newspaper < ActiveRecord::Base
  validates_presence_of :name, :country_id
  validates_numericality_of :country_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_uniqueness_of :name, :scope => [:country_id]
  validates_associated :country, :on => :update
  belongs_to :country	
end
