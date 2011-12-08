class User < ActiveRecord::Base
  extend LDAP::Helpers::UserModel
  extend Aleph::Helpers::UserModel
  
  if ldap_enabled?
    devise :ldap_authenticatable, :timeoutable, :lockable
  else
    devise :database_authenticatable, :encryptable, :timeoutable, :lockable
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me,
                  :userstatus_id, :user_incharge_id, :user_identifications_attributes,
                  :person_attributes, :address_attributes, :jobposition_attributes,
                  :jobposition_log_attributes, :user_group_attributes,
                  :user_schoolarships_attributes, :documents_attributes,
                  :author_name, :blog, :homepage, :calendar, :user_cite_attributes

  scope :activated, where(:userstatus_id => 2)
  scope :locked, where('userstatus_id != 2')
  scope :postdoctoral, joins(:jobposition, :user_adscriptions).where("jobpositions.jobpositioncategory_id = 38  AND user_adscriptions.jobposition_id = jobpositions.id")
  scope :not_in_postdoctoral, joins(:jobposition, :user_adscriptions).where("jobpositions.jobpositioncategory_id != 38  AND user_adscriptions.jobposition_id = jobpositions.id")
  scope :fullname_asc, joins(:person).order('people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC')
  scope :fullname_desc, joins(:person).order('people.lastname1 DESC, people.lastname2 DESC, people.firstname DESC')
  scope :distinct, select("DISTINCT (users.*)")

  # :userstatus_id_equals => find_all_by_userstatus_id
  scope :fullname_like, lambda { |fullname| where(" users.id IN (#{Person.find_by_fullname(fullname).select('user_id').to_sql}) ") }
  scope :adscription_id_equals, lambda { |adscription_id| joins(:user_adscriptions).where(["user_adscriptions.adscription_id = ?", adscription_id] ) }
  scope :schoolarship_id_equals, lambda { |schoolarship_id| joins(:user_schoolarships).where(["user_schoolarships.schoolarship_id = ?", schoolarship_id] ) }
  scope :annual_report_year_equals, lambda { |year| includes(:documents).where(["documents.documenttype_id = 1 AND documents.title = ?", year]) }
  scope :jobposition_start_date_year_equals, lambda { |year| where(" users.id IN (#{Jobposition.by_year(year, :field => :start_date).select('DISTINCT(user_id) AS user_id').to_sql}) ") }
  scope :jobposition_end_date_year_equals, lambda { |year| where(" users.id IN (#{Jobposition.by_year(year, :field => :end_date).select('DISTINCT(user_id) AS user_id').to_sql}) ") }
  scope :jobpositioncategory_id_equals, lambda { |jobpositioncategory_id| joins(:jobpositions).where(["jobpositions.jobpositioncategory_id = ?", jobpositioncategory_id]) }

  search_methods :fullname_like, :adscription_id_equals, :schoolarship_id_equals, :annual_report_year_equals, 
                 :jobposition_start_date_year_equals, :jobposition_end_date_year_equals, :jobpositioncategory_id_equals,
                 :login_like

  belongs_to :userstatus
  belongs_to :user_incharge, :class_name => 'User', :foreign_key => 'user_incharge_id'
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  has_one :person
  has_one :user_group
  has_one :address
  has_one :jobposition, :order => 'jobpositions.start_date DESC, jobpositions.end_date DESC'
  has_one :user_identification
  has_one :user_schoolarship
  has_one :user_cite
  has_one :jobposition_log

  has_many :user_adscriptions
  has_many :jobpositions
  has_one  :user_adscription, :include => :jobposition, :order => 'user_adscriptions.start_date DESC, user_adscriptions.end_date DESC'
  has_one  :jobposition_as_postdoctoral, :class_name => 'Jobposition', :conditions => 'jobpositions.jobpositioncategory_id = 38', :order => 'jobpositions.start_date DESC, jobpositions.end_date DESC'
  has_one  :user_adscription_as_postdoctoral, :class_name => 'UserAdscription', :conditions => 'jobpositions.jobpositioncategory_id = 38 and user_adscriptions.jobposition_id = jobpositions.id', :include => :jobposition, :order => 'user_adscriptions.start_date DESC, user_adscriptions.end_date DESC'
  has_many :user_schoolarships, :order => 'user_schoolarships.start_date DESC, user_schoolarships.end_date DESC'
  has_many :user_schoolarships_as_posdoctoral, :conditions => "user_schoolarships.schoolarship_id >=48  AND user_schoolarships.schoolarship_id <= 53", :order => 'user_schoolarships.start_date DESC, user_schoolarships.end_date DESC', :class_name => 'UserSchoolarship'
  has_many :documents
  has_many :user_identifications

  accepts_nested_attributes_for :person, :address, :jobposition, :user_group, :user_schoolarships, :documents, :user_schoolarship
  accepts_nested_attributes_for :user_identifications, :allow_destroy => true
  accepts_nested_attributes_for :user_cite

  def self.paginated_search(options={})
    search(options[:search]).paginate(:page => options[:page] || 1, :per_page =>  options[:per_page] || 10)
  end

  def self.login_like(login)
    @users = where(:login.matches => "%#{login.downcase}%")
    @users += ldap_users_like(login) if ldap_enabled?
    @users
  end

  def author_name
    if !super.nil?
      super
    elsif !user_cite.nil? and !user_cite.author_name.to_s.strip.empty?
      user_cite.author_name
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

  def firstname_and_lastname
     has_person? ? person.firstname_and_lastname : email
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

  def has_image?
    !person.nil? and !person.image.nil?
  end

  def avatar(version=:icon)
    if !person.nil? and !person.image.nil?
      person.image.file.url(version.to_sym)
    else
      "/images/avatar_missing_#{version}.png"
    end
  end

  def update_password(attr)
    if User.ldap_enabled?
      new_password_valid?(attr) and update_ldap_password(attr)
    else
      new_password_valid?(attr) and update_with_password(attr)
    end
  end

  def new_password_valid?(attr)
    if !attr[:password].blank? and !attr[:password_confirmation].blank? and attr[:password] == attr[:password_confirmation]
      true
    else
      errors.add(:password, :confirmation)
      false
    end
  end

  def update_ldap_password(attr)
    if valid_ldap_authentication?(attr[:current_password])
      update_attributes(attr)
    else
      errors.add(:current_password, :invalid)
      false
    end
  end
end
