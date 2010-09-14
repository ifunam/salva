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

  scope :activated, where(:userstatus_id => 2)
  scope :locked, where('userstatus_id != 2')
  scope :posdoc, joins(:jobposition, :user_adscriptions).where("jobpositions.jobpositioncategory_id = 38  AND user_adscriptions.jobposition_id = jobpositions.id")
  scope :fullname_asc, joins(:person).order('people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC')
  scope :fullname_desc, joins(:person).order('people.lastname1 DESC, people.lastname2 DESC, people.firstname DESC')
  scope :distinct, select("DISTINCT (users.*)")

  # :userstatus_id_equals => find_all_by_userstatus_id  
  scope :fullname_like, lambda { |fullname| where(" users.id IN (#{Person.find_by_fullname(fullname).select('user_id').to_sql}) ") }
  scope :adscription_id_equals, lambda { |adscription_id| joins(:user_adscriptions).where(["user_adscriptions.adscription_id = ?", adscription_id] ) }
  scope :schoolarship_id_equals, lambda { |schoolarship_id| joins(:user_schoolarships).where(["user_schoolarships.schoolarship_id = ?", schoolarship_id] ) }
  scope :annual_report_year_equals, lambda { |year| includes(:documents).where(["documents.documenttype_id = 1 AND documents.title = ?", year]) }
  scope :jobposition_start_date_year_equals, lambda { |year| where(" users.id IN (#{UserAdscription.by_year(year, :field => :start_date).select('user_id').to_sql}) ") }
  scope :jobposition_end_date_year_equals, lambda { |year| where(" users.id IN (#{UserAdscription.by_year(year, :field => :end_date).select('user_id').to_sql}) ") }

  search_methods :fullname_like, :adscription_id_equals, :schoolarship_id_equals, :annual_report_year_equals, :jobposition_start_date_year_equals, :jobposition_end_date_year_equals
  
  belongs_to :userstatus
  belongs_to :user_incharge, :class_name => 'User', :foreign_key => 'user_incharge_id'

  has_one :person
  has_one :user_group
  has_one :address
  has_one :jobposition
  has_one  :user_identification

  has_many :user_adscriptions
  has_one  :user_as_posdoc_adscription, :class_name => 'UserAdscription', :conditions => 'jobpositions.jobpositioncategory_id = 38 and user_adscriptions.jobposition_id = jobpositions.id', :include => :jobposition, :order => 'user_adscriptions.start_date DESC, user_adscriptions.end_date DESC'
  has_many :user_schoolarships, :order => 'user_schoolarships.start_date DESC, user_schoolarships.end_date DESC'
  has_many :documents
  accepts_nested_attributes_for :person, :address, :jobposition, :user_group, :user_identification, :user_schoolarships, :documents
  
  def self.posdoc_search(search_options={}, page=1, per_page=10)
    posdoc.fullname_asc.search(search_options).all.paginate(:page => page, :per_page => per_page)
  end

  def self.login_likes(login)
    where(:login.matches => "%#{login.downcase}%")
  end

  def initialize(*args)
    super
    [:person, :user_group, :address, :jobposition, :user_identification].each do |association_name|
      send "#{association_name}=", ActiveSupport::Inflector.camelize(association_name).constantize.new
    end
    jobposition.user_adscription = UserAdscription.new
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

  def friendly_email
    "#{fullname_or_email} <#{email}>"
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
