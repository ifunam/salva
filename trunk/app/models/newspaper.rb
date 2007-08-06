class Newspaper < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :country_id, :allow_nil => true, :only_integer => true

  validates_presence_of :name, :country_id
  validates_uniqueness_of :name, :scope => [:country_id]

  belongs_to :country

  validates_associated :country, :on => :update
end
