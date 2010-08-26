class User < ActiveRecord::Base
  validates_presence_of :login, :userstatus_id, :email, :password
  validates_confirmation_of :password

  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me, 
                  :userstatus_id, :user_incharge_id,
                  :person_attributes, :address_attributes, :jobposition_attributes, 
                  :jobposition_log_attributes, :user_group_attributes

  belongs_to :userstatus
  belongs_to :user_incharge, :class_name => 'User', :foreign_key => 'user_incharge_id'

  has_one :person
  
  scope :activated, where(:userstatus_id => 2)
  scope :locked, where('userstatus_id != 2')
  scope :with_person, includes(:person).order('people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC')
  scope :posdoc, includes(:jobposition).where("jobpositions.jobpositioncategory_id = 38")

  # These relationships will be changed to has_many
  has_one :address
  has_one :jobposition
  has_one :jobposition_log
  has_one :user_group

  accepts_nested_attributes_for :person, :address, :jobposition, :jobposition_log, :user_group
  
  def self.posdoc_search(search_options={}, page=1, per_page=10)
    posdoc.with_person.search(search_options).all.paginate(:page => page, :per_page => per_page)
  end

  def authorname
    if !author_name.to_s.strip.empty?
       author_name
    elsif !person.nil?
      person.shortname
    end
  end

  def fullname_or_login
     person.nil? ? login : person.fullname
  end

  def fullname_or_email
     person.nil? ? email : person.fullname
  end

  def user_incharge_fullname
    user_incharge.nil? ? '' : user_incharge.fullname_or_login
  end

  def avatar(version=:icon)
    if !person.nil? and !person.image.nil?
      person.image.file.url(version.to_sym)
    else
      "/images/avatar_missing_#{version}.png"
    end
  end

end
