class Newspaper < ActiveRecord::Base
  validates_presence_of :name, :country_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :country_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name
  # attr_accessor :name, :url, :country_id

  belongs_to :country
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :newspaperarticles
  has_many :user_newspaperarticles

  def name_and_country
    !country.nil? ? [name, country.name].join(', ') : name
  end
end
