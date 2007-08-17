class Identification < ActiveRecord::Base
  validates_presence_of :idtype_id, :country_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :idtype_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :country_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :idtype_id, :scope => [:country_id]

  belongs_to :idtype
  belongs_to :country, :class_name => 'Country', :foreign_key => 'country_id'
end
