class City < ActiveRecord::Base
  validates_presence_of :state_id, :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :state_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:state_id]
  normalize_attributes :name

  belongs_to :state
  has_many :people
  has_many :addresses
  #scope_by_soundex :name_likes, :fields => [:name]
  search_methods :name_likes
  
  default_scope :order => 'name ASC'

  def self.name_likes(name)
    where('LOWER(cities.name) LIKE ?', "%#{name.downcase}%")
  end
end
