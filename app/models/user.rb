class User < ActiveRecord::Base
  validates_presence_of :login, :userstatus_id, :email, :password
  validates_confirmation_of :password

  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me,
                  :userstatus_id, :user_incharge_id, :user_identification_attributes,
                  :person_attributes, :address_attributes, :jobposition_attributes,
                  :jobposition_log_attributes, :user_group_attributes,
                  :user_schoolarships_attributes, :documents_attributes

  scope :activated, where(:userstatus_id => 2)
  scope :locked, where('userstatus_id != 2')
  scope :postdoctoral, joins(:jobposition, :user_adscriptions).where("jobpositions.jobpositioncategory_id = 38  AND user_adscriptions.jobposition_id = jobpositions.id")
  scope :not_in_postdoctoral, joins(:jobposition, :user_adscriptions).where("jobpositions.jobpositioncategory_id != 38  AND user_adscriptions.jobposition_id = jobpositions.id")
  scope :fullname_asc, joins(:person).order('people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC')
  scope :fullname_desc, joins(:person).order('people.lastname1 DESC, people.lastname2 DESC, people.firstname DESC')
  scope :distinct, select("DISTINCT (users.*)")

  # :userstatus_id_equals => find_all_by_userstatus_id
  scope :fullname_likes, lambda { |fullname| where(" users.id IN (#{Person.find_by_fullname(fullname).select('user_id').to_sql}) ") }
  scope :adscription_id_equals, lambda { |adscription_id| joins(:user_adscriptions).where(["user_adscriptions.adscription_id = ?", adscription_id] ) }
  scope :schoolarship_id_equals, lambda { |schoolarship_id| joins(:user_schoolarships).where(["user_schoolarships.schoolarship_id = ?", schoolarship_id] ) }
  scope :annual_report_year_equals, lambda { |year| includes(:documents).where(["documents.documenttype_id = 1 AND documents.title = ?", year]) }
  scope :jobposition_start_date_year_equals, lambda { |year| where(" users.id IN (#{Jobposition.by_year(year, :field => :start_date).select('DISTINCT(user_id) AS user_id').to_sql}) ") }
  scope :jobposition_end_date_year_equals, lambda { |year| where(" users.id IN (#{Jobposition.by_year(year, :field => :end_date).select('DISTINCT(user_id) AS user_id').to_sql}) ") }

  search_methods :fullname_likes, :adscription_id_equals, :schoolarship_id_equals, :annual_report_year_equals, :jobposition_start_date_year_equals, :jobposition_end_date_year_equals, :login_likes

  belongs_to :userstatus
  belongs_to :user_incharge, :class_name => 'User', :foreign_key => 'user_incharge_id'
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'

  has_one :person
  has_one :user_group
  has_one :address
  has_one :jobposition
  has_one :user_identification
  has_one :user_schoolarship

  has_many :user_adscriptions
  has_one  :user_adscription, :include => :jobposition, :order => 'user_adscriptions.start_date DESC, user_adscriptions.end_date DESC'
  has_one  :jobposition_as_postdoctoral, :class_name => 'Jobposition', :conditions => 'jobpositions.jobpositioncategory_id = 38', :order => 'jobpositions.start_date DESC, jobpositions.end_date DESC'
  has_one  :user_adscription_as_postdoctoral, :class_name => 'UserAdscription', :conditions => 'jobpositions.jobpositioncategory_id = 38 and user_adscriptions.jobposition_id = jobpositions.id', :include => :jobposition, :order => 'user_adscriptions.start_date DESC, user_adscriptions.end_date DESC'
  has_many :user_schoolarships, :order => 'user_schoolarships.start_date DESC, user_schoolarships.end_date DESC'
  has_many :user_schoolarships_as_posdoctoral, :conditions => "user_schoolarships.schoolarship_id >=48  AND user_schoolarships.schoolarship_id <= 53", :order => 'user_schoolarships.start_date DESC, user_schoolarships.end_date DESC', :class_name => 'UserSchoolarship'
  has_many :documents
  accepts_nested_attributes_for :person, :address, :jobposition, :user_group, :user_identification, :user_schoolarships, :documents, :user_schoolarship

  
  def self.paginated_search(options={})
    search(options[:search]).paginate(:page => options[:page] || 1, :per_page =>  options[:per_page] || 10)
  end

  def self.login_likes(login)
    @users = where(:login.matches => "%#{login.downcase}%")
    # NOTE: Comment this block if you don't want to interact with your ldap server
    LDAP::User.all_by_login_likes(login.downcase).each do |ldap_user|
      @users.push(new(:login => ldap_user.login, :email => ldap_user.email)) if find_by_login(ldap_user.login).nil?
    end
    @users
  end

  def authorname
    if !author_name.to_s.strip.empty?
       author_name
    elsif !person.nil?
      person.shortname
    end
  end

  def fullname_or_login
     has_person? ? person.fullname : login
  end

  def fullname_or_email
     has_person? ? person.fullname : email
  end

  def has_person?
    !person.nil? and !person.id.nil?
  end

  def friendly_email
    "#{fullname_or_email} <#{email}>"
  end

  def user_incharge_fullname
    user_incharge.fullname_or_login unless user_incharge.nil?
  end

  def fullname_of_registered_by
    registered_by.fullname_or_login unless registered_by.nil?
  end

  def adscription_name
    user_adscription.adscription.name if has_adscription?
  end

  def adscription_abbrev
    user_adscription.adscription.abbrev if has_adscription?
  end

  def has_adscription?
    !user_adscription.nil?
  end
  def category_name
    jobposition.category_name unless jobposition.nil?
  end

  def avatar(version=:icon)
    if !person.nil? and !person.image.nil?
      person.image.file.url(version.to_sym)
    else
      "/images/avatar_missing_#{version}.png"
    end
  end
end
