class Identification < ActiveRecord::Base
  validates_presence_of :idtype_id, :citizen_country_id
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :idtype_id, :citizen_country_id, :allow_nil => false,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :idtype_id, :scope => [:citizen_country_id]

  belongs_to :idtype
  belongs_to :citizen_country, :class_name => 'Country', :foreign_key => 'citizen_country_id'

  has_many :people_identifications
  has_many :identifications, :through => :people_identifications

  validates_associated :people_identifications
end
