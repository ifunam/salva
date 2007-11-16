class Book < ActiveRecord::Base
  validates_presence_of :title, :authors, :country_id, :booktype_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :country_id, :booktype_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :language_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :title, :scope => [:title, :authors, :country_id, :booktype_id, :language_id]
  
  belongs_to :country
  belongs_to :booktype
  belongs_to :language
  validates_associated :country, :booktype, :language

  has_many :bookeditions
  validates_associated :bookeditions
end
