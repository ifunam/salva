class Person < ActiveRecord::Base
  
  validates_presence_of :firstname, :lastname1, :dateofbirth, :country_id
  validates_numericality_of :country_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :maritalstatus_id, :city_id, :state_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_inclusion_of :gender, :in => [true, false]
  validates_uniqueness_of :user_id

  normalize_attributes :firstname, :lastname1, :lastname2

  belongs_to :user
  belongs_to :maritalstatus
  belongs_to :country
  belongs_to :state
  belongs_to :city
  
  has_one :image, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :image, :city
 
  default_scope :order => 'people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC'
  scope_by_difference :find_by_fullname, :fields => [:firstname, :lastname1, :lastname2]
  search_methods :find_by_fullname

  def fullname
    [self.lastname1.strip, (self.lastname2 != nil ? self.lastname2.strip : nil), self.firstname].compact.join(' ')
  end

  def firstname_and_lastname
    [self.firstname, self.lastname1.strip, (self.lastname2 != nil ? self.lastname2.strip : nil)].compact.join(' ')
  end

  def shortname
    [self.lastname1.strip,  self.firstname].compact.join(' ')
  end

  def placeofbirth
    [self.city.name,  self.state.name, self.country.name].compact.join(', ')
  end

  def age
    now = Time.now.utc.to_date
    now.year - dateofbirth.year - (dateofbirth.to_date.change(:year => now.year) > now ? 1 : 0)
  end
end
