class State < ActiveRecord::Base
  validates_presence_of :country_id, :name
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :country_id,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:country_id]
  

  belongs_to :country

  has_many :cities
  has_many :people
  has_many :addresses
  has_many :institutions

  validates_associated :country

  default_scope :order => 'name ASC'
  
  
  search_methods :name_likes

  default_scope :order => 'name ASC'

  def self.name_likes(name)
    where('LOWER(states.name) LIKE ?', "%#{name.downcase}%")
  end

end
