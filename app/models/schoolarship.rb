class Schoolarship < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :institution_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :name, :scope => [:institution_id]

  belongs_to :institution
  validates_associated :institution

  search_methods :name_likes

  default_scope :order => 'name ASC'

  def self.name_likes(name)
    where('LOWER(schoolarships.name) LIKE ?', "%#{name.downcase}%")
  end

  def name_and_institution_abbrev
     institution.nil? ? name : [name, institution.abbrev].join(' - ')
  end
  
  has_many :user_schoolarships
end

