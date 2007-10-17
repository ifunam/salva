class Journal < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :mediatype_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :country_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :publisher_id, :allow_nil => true, :only_integer => true
  validates_presence_of :name, :mediatype_id, :country_id
  validates_uniqueness_of :name, :scope => [:issn, :country_id, :mediatype_id]

  belongs_to :mediatype
  belongs_to :publisher
  belongs_to :country
end
