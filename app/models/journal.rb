class Journal < ActiveRecord::Base
  attr_accessible :name, :mediatype_id, :country_id
  validates_presence_of :name, :mediatype_id, :country_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :mediatype_id, :country_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :publisher_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:issn, :country_id, :mediatype_id]

  belongs_to :mediatype
  belongs_to :publisher
  belongs_to :country
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  validates_associated :mediatype
  validates_associated :publisher
  validates_associated :country

  has_many :user_journals
  has_many :articles
  has_many :user_refereed_journals

  default_scope :order => 'name ASC'
end
