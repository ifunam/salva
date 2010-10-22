class City < ActiveRecord::Base
  validates_presence_of :state_id, :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :state_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:state_id]
  normalize_attributes :name

  belongs_to :state
  has_many :people
  has_many :addresses
  has_many :institutions
  search_methods :name_likes
  
  default_scope :order => 'name ASC'

  def self.name_likes(name)
    where('LOWER(cities.name) LIKE ?', "%#{name.downcase}%")
  end

  def self.destroy_all_with_empty_associations
    all.each do |record|
      record.destroy_if_associations_are_empty
    end
  end

  def destroy_if_associations_are_empty 
    destroy unless has_associated_records?
  end
  
  def move_association(association_name, new_city_id)
    if self.respond_to? association_name
      self.send(association_name.to_sym).each { |record| record.update_attributes(:city_id => new_city_id) }
    end
  end
  
  def move_associations(new_city_id)
    self.class.reflect_on_all_associations(:has_many).collect do |association|
      move_association(association.name, new_city_id)
    end
  end
  
  def has_associated_records?
    associated_records_size > 0
  end
  
  def associated_records_size
    associated_records = 0
    self.class.reflect_on_all_associations(:has_many).collect do |association|
      associated_records += self.send(association.name).size
    end
    associated_records
  end
end
