# encoding: utf-8
require File.join(Rails.root.to_s, 'lib/clients/student_client')
require_relative '../../lib/aleph/helpers/user_model'
require_relative '../../lib/ldap/helpers/user_model'
class User < ActiveRecord::Base
  after_create :request_id_card
  after_update :user_updates
  before_destroy :destroy_connected_users

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessor :email, :password, :password_confirmation, :remember_me
  extend LDAP::Helpers::UserModel
  extend Aleph::Helpers::UserModel

  if ldap_enabled?
    devise :ldap_authenticatable, :timeoutable, :lockable
  else
    # Uncomment this line if you are using a new database
    # devise :database_authenticatable, :timeoutable, :lockable

    # Comment this line if uncomment the previous line, it is useful for users with previous versions of salva
    devise :database_authenticatable, :timeoutable, :lockable, :encryptable, :encryptor => :salva_sha512, :stretches => 40

    # Uncomment the following line If you want to enable the email
    # attribute for modifications in systems without ldap support.
    # # attr_accessor :email
  end

  # Setup accessible (or protected) attributes for your model
  # attr_accessor :current_password

  validates :email, :presence => true, :uniqueness => true
  validates :login, :presence => true, :length => { :minimum => 5, :maximum => 15 },  :format => { :with => /\A([a-z]|.)+\z/ }, :uniqueness => true, :on => :create # The provided regular expression is using multiline anchors (^ or $), which may present a security risk. Did you mean to use \A and \z, or forgot to add the :multiline => true option? (ArgumentError)
  validates :login, :presence => true, :format => { :with => /\A([a-z]|.)+\z/ }, :uniqueness => true, :on => :update # The provided regular expression is using multiline anchors (^ or $), which may present a security risk. Did you mean to use \A and \z, or forgot to add the :multiline => true option? (ArgumentError)
  validates :password, :presence =>true, :length => { :minimum => 8, :maximum => 40 }, :confirmation => true, :on => :create
  validates_confirmation_of :password
  validates_length_of :homepage_resume,:homepage_resume_en, :maximum => 1500

  # attr_accessor :password, :password_confirmation, :remember_me, :user_identifications_attributes,
                  # :person_attributes, :address_attributes, :jobposition_attributes, :current_password,
                  # :jobposition_log_attributes, :user_schoolarships_attributes, :reports_attributes,
                  # :author_name, :blog, :homepage, :calendar, :user_cite_attributes,
                  # :homepage_resume, :homepage_resume_en, :login, :userstatus_id, :user_incharge_id, 
                  # :user_group_attributes

  scope :activated, -> { where(:userstatus_id => 2) }
  scope :inactive, -> { where('userstatus_id != 2') }
  scope :postdoctoral, -> { joins(:jobposition, :user_adscriptions).where("jobpositions.jobpositioncategory_id = 38  AND user_adscriptions.jobposition_id = jobpositions.id") }
  scope :not_in_postdoctoral, -> { joins(:jobposition, :user_adscriptions).where("jobpositions.jobpositioncategory_id != 38  AND user_adscriptions.jobposition_id = jobpositions.id") }

  scope :conacyt, -> { joins(:jobposition, :user_adscriptions).where("jobpositions.jobpositioncategory_id = 185  AND user_adscriptions.jobposition_id = jobpositions.id") }
  scope :not_in_conacyt, -> { joins(:jobposition, :user_adscriptions).where("jobpositions.jobpositioncategory_id != 185  AND user_adscriptions.jobposition_id = jobpositions.id") }
  scope :fullname_asc, -> { joins(:person).order('people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC') }
  scope :fullname_desc, -> { joins(:person).order('people.lastname1 DESC, people.lastname2 DESC, people.firstname DESC') }
  scope :toberenamed, -> { select("DISTINCT (users.*)") } # distinct is a reserved scope. check how this affects your app
  scope :sort_by_author, -> { order('author_name ASC') }

  scope :researchers, -> { joins(:user_adscription_records, :jobposition=>:jobpositioncategory).where("jobpositioncategories.roleinjobposition_id IN (1,110,114) AND user_adscription_records.jobposition_id = jobpositions.id AND user_adscription_records.year = ?",Time.now.year) }
  scope :academic_technicians, -> { joins(:user_adscription_records, :jobposition=>:jobpositioncategory).where("jobpositioncategories.roleinjobposition_id = 3 AND (jobpositioncategories.roleinjobposition_id NOT IN (1,110,4,5)) AND user_adscription_records.jobposition_id = jobpositions.id AND user_adscription_records.year = ?",Time.now.year) }
  #posdoctorals_and_conacytchair 111,114
  scope :posdoctorals, -> { joins(:user_adscription_records, :jobposition=>:jobpositioncategory).where("jobpositioncategories.roleinjobposition_id IN (111) AND user_adscription_records.jobposition_id = jobpositions.id AND user_adscription_records.year = ?",Time.now.year) }
  scope :conacyt, -> { joins(:user_adscription_records, :jobposition=>:jobpositioncategory).where("jobpositioncategories.roleinjobposition_id IN (114)  AND user_adscription_records.jobposition_id = jobpositions.id AND user_adscription_records.year = ?",Time.now.year) }
  #researchers_posdoctorals_and_conacytchair 1,110,111,114
  scope :researchers_and_posdoctorals, -> { joins(:user_adscription_records, :jobposition=>:jobpositioncategory).where("jobpositioncategories.roleinjobposition_id IN (1,110,111,114)  AND user_adscription_records.jobposition_id = jobpositions.id AND user_adscription_records.year = ?",Time.now.year) }
  scope :activated_academics, lambda { self.researchers_and_posdoctorals.activated | self.academic_technicians.activated }
  scope :all_except, lambda { |user| where("userstatus_id=2 AND users.id NOT IN (?)",user) }
  # :userstatus_id_equals => find_all_by_userstatus_id
  scope :fullname_like, lambda { |fullname| 
    sql = " users.id IN (#{Person.user_id_by_fullname_like(fullname).to_sql}) "
    where sql
  }
  scope :fullname_contains, lambda { |fullname| fullname_like(fullname) }
  scope :fullname_equals, lambda { |fullname| fullname_like(fullname) }
  scope :fullname_starts_with, lambda { |fullname| fullname_like(fullname) }
  scope :fullname_ends_with, lambda { |fullname| fullname_like(fullname) }

  scope :adscription_id_equals, lambda { |adscription_id| joins(:user_adscriptions).where(["user_adscriptions.adscription_id = ?", adscription_id] ) }
  scope :adscription_eq, lambda { |adscription_id| adscription_id_equals(adscription_id) }
  scope :schoolarship_id_equals, lambda { |schoolarship_id| joins(:user_schoolarships).where(["user_schoolarships.schoolarship_id = ?", schoolarship_id] ) }
  scope :schoolarship_eq, lambda { |schoolarship_id| schoolarship_id_equals(schoolarship_id) }
  scope :annual_report_year_equals, lambda { |year| includes(:documents).where(["documents.documenttype_id = 1 AND documents.title = ?", year]) }

  scope :jobposition_start_date_year_equals, lambda { |year|
    sql = " users.id IN (#{Jobposition.user_id_by_start_date_year(year).to_sql}) "
    where sql
  }
  scope :jobposition_start_date_year_eq, lambda { |y| jobposition_start_date_year_equals(y) }

  scope :jobposition_end_date_year_equals, lambda { |year|

    sql = " users.id IN (#{Jobposition.user_id_by_end_date_year(year).to_sql}) "
    where sql
  }
  scope :jobposition_end_date_year_eq, lambda { |y| jobposition_end_date_year_equals(y) }

  scope :jobpositioncategory_id_equals, lambda { |jobpositioncategory_id|
    last_jp=find_by_sql("SELECT users.* FROM users
                 JOIN (select jobpositions.* from jobpositions
                   join (select user_id,max(start_date) maxDate from jobpositions where institution_id=30 group by user_id) b on jobpositions.user_id = b.user_id
                                and jobpositions.start_date = b.maxDate) as jp
                 ON jp.user_id=users.id
                 WHERE users.userstatus_id=2 and jp.jobpositioncategory_id = "+jobpositioncategory_id.to_s)
    joins(:jobpositions).where(:id => last_jp.map(&:id)).distinct
  }
  scope :jobpositioncategory_eq, lambda { |jobpositioncategory_id| jobpositioncategory_id_equals(jobpositioncategory_id) }

  # search_methods :fullname_like, :adscription_id_equals, :schoolarship_id_equals, :annual_report_year_equals, 
  #                :jobposition_start_date_year_equals, :jobposition_end_date_year_equals, :jobpositioncategory_id_equals,
  #                :login_like, :adscription_eq, :jobpositioncategory_eq, :jobposition_start_date_year_eq,
  #                :jobposition_end_date_year_eq, :fullname_contains, :schoolarship_eq, :fullname_equals, 
  #                :fullname_starts_with, :fullname_ends_with

  belongs_to :userstatus
  belongs_to :user_incharge, :class_name => 'User', :foreign_key => 'user_incharge_id'
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  has_one :person
  has_one :user_group
  has_one :group, :through => :user_group
  has_one :address
  has_one :professional_address, -> { where(addresses: { addresstype_id: 1 }) }, :class_name => "Address" 
  has_one :jobposition, -> { order(jobpositions: { start_date: :desc, end_date: :desc }) }
  has_one :most_recent_jobposition, -> { include(:institution).where("(institutions.institution_id = 1 OR institutions.id = 1) AND jobpositions.institution_id = institutions.id ").order(jobpositions: { start_date: :desc }) },
            :class_name => "Jobposition"
  has_one :first_jobposition, -> { include(:institution).where("(institutions.institution_id = 1 OR institutions.id = 1) AND jobpositions.institution_id = institutions.id ").order(jobpositions: { start_date: :desc }) },
            :class_name => "Jobposition"
  has_one :jobposition_for_researching, -> { include(:institution, :jobpositioncategory).where("(institutions.institution_id = 1 OR institutions.id = 1) AND jobpositions.institution_id = institutions.id AND jobpositioncategories.jobpositiontype_id = 1").order(jobpositions: { start_date: :desc }) }, 
            :class_name => "Jobposition"
  has_one :user_identification
  has_one :user_schoolarship
  has_one :user_cite
  has_one :jobposition_log
  has_one :session_preference
  has_one :department_head
  has_many :user_adscriptions
  has_many :user_adscription_records
  has_many :jobpositions
  has_one  :user_adscription, -> {include(:jobposition).order(user_adscriptions: { start_date: :desc, end_date: :desc }) }
  has_one  :jobposition_as_conacyt, -> { where(jobpositions: { jobpositioncategory_id: 185 }).order(jobposition: { start_date: :desc, end_date: :desc}) }, :class_name => 'Jobposition'
  has_one  :user_adscription_as_conacyt, -> { where(jobpositions: {jobpositioncategory_id: 185}, user_adscriptions: { jobposition_id: jobpositions.id }).include(:jobposition).order(user_adscriptions: { start_date: :desc, end_date: :desc }) }, :class_name => 'UserAdscription' # TODO: check correct syntax for user_adscriptions: { jobposition_id: jobpositions.id })
  has_one  :jobposition_as_postdoctoral, -> { where(jobpositions: { jobpositioncategory_id: 38 }).order(jobpositions: { start_date: :desc, end_date: :desc }) }, :class_name => 'Jobposition'
  has_one  :user_adscription_as_postdoctoral, -> { where(jobpositions: { jobpositioncategory_id: 38 }, user_adscription: { jobposition_id: jobpositions.id }).include(:jobposition).order(user_adscriptions: { start_date: :desc, end_date: :desc }) }, :class_name => 'UserAdscription' # TODO: check correct syntax for user_adscriptions: { jobposition_id: jobpositions.id })
  has_many :user_schoolarships, -> { order(user_schoolarship: { start_date: :desc, end_date: :desc }) }
  has_many :user_schoolarships_as_posdoctoral, -> { where(user_schoolarships: { schoolarship_id: 48..53 }).order(user_schoolarships: { start_date: :desc, end_date: :desc }) }, :class_name => 'UserSchoolarship'
  has_many :documents
  has_many :reports
  has_many :user_identifications
  has_many :videos
  has_many :user_lab_or_groups
  has_many :lab_or_groups, -> { order(lab_or_groups: { name: :asc}).limit(10) }, :through => :user_lab_or_groups
  has_many :user_knowledge_areas
  has_many :knowledge_areas, -> { order(knowledge_areas: { name: :asc }).limit(10) }, :through => :user_knowledge_areas
  has_many :user_researchlines
  has_many :researchlines, -> { order(researchlines: { name: :asc }).limit(10) }, :through => :user_researchlines
  has_many :user_skills
  has_many :user_articles, -> { include(:articles) }, :inverse_of => :user
  has_many :articles, :through => :user_articles, :inverse_of => :users
  has_many :user_refereed_journals, -> { include(:journal) }, :inverse_of => :user
  has_many :journals, :through => :user_refereed_journals
  has_many :published_articles, -> { where(articles: { articlestatus_id: 3 }).order(articles: { year: :desc, month: :desc, authors: :asc, title: :asc }) }, :through => :user_articles, :source => :article
  has_many :recent_published_articles, -> { where(articles: { articlestatus_id: 3 }).order({ articles: { year: :desc, month: :desc, authors: :asc, title: :asc } }).limit(5) }, :through => :user_articles, :source => :article
  has_many :inprogress_articles, -> { where.not(articles: { articlestatus_id: 3}).order( { articles: { year: :desc, month: :desc, authors: :asc, title: :asc } }) }, :through => :user_articles, :source => :article
  has_many :user_theses
  has_many :theses, :through => :user_theses
  has_many :bookedition_roleinbooks
  has_many :bookeditions, :through => :bookedition_roleinbooks
  has_many :chapterinbook_roleinchapters
  has_many :chapterinbooks, :through => :chapterinbook_roleinchapters

  accepts_nested_attributes_for :person, :address, :jobposition, :jobposition_log, :user_group, :user_schoolarships, :reports, :user_schoolarship
  accepts_nested_attributes_for :user_identifications, :allow_destroy => true
  accepts_nested_attributes_for :user_cite

  def self.paginated_search(options={})
    search(options[:search]).page(options[:page] || 1).per(options[:per_page] || 10)
  end

  def self.login_like(login)
    login_sql = "%#{login.downcase}%"
    @users = where("users.login LIKE ?", login_sql)
    @users += ldap_users_like(login) if ldap_enabled?
    users
  end

  def self.last_jp(adscription_id)
    find_by_sql("
    SELECT users.* FROM users
                 JOIN (
                 select user_adscriptions.* FROM user_adscriptions
              JOIN (select jobpositions.* from jobpositions join (select user_id,max(start_date) maxDate from jobpositions group by user_id) b
                           on jobpositions.user_id = b.user_id and jobpositions.start_date = b.maxDate) jobpositions
                           ON user_adscriptions.jobposition_id = jobpositions.id
                                ) as ad
                 ON ad.user_id=users.id
                 WHERE users.userstatus_id=2 and ad.adscription_id = "+adscription_id.to_s)
  end

  def to_s
    [title_and_fullname, ' <', email,'>'].join
  end

  def author_name
    if !super.to_s.strip.empty?
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
  alias :name :fullname_or_email


  def title
    person.title if has_person?
  end

  def title_en
    person.title_en if has_person?
  end
  
  def title_and_fullname
    [title, firstname_and_lastname].compact.join(' ')
  end

  def title_and_fullname_en
    [title_en, firstname_and_lastname].compact.join(' ')
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

  def adscription_name(user_id,year)
    @year = (year.nil? or year<2015) ? 2015 : year
    uar = UserAdscriptionRecord.where(:user_id=>user_id,:year=>@year)
    Adscription.find(uar.map(&:adscription_id)[0]).name unless uar.size==0
  end

  def adscription_abbrev
    user_adscription.adscription.abbrev if has_adscription?
  end

  def adscription_id
    if has_adscription?
      uar = UserAdscriptionRecord.where(:user_id=>id,:year=>Time.now.year)
      uar.map(&:adscription_id).first
    end
  end

  def has_adscription?
    !user_adscription.nil?
  end

  def category_name
    most_recent_jobposition.category_name unless most_recent_jobposition.nil?
  end

  def has_image?
    !person.nil? and !person.image.nil?
  end

  def avatar(version=:icon)
    if !person.nil? and !person.image.nil? and person.image.is_a? Image and person.image.respond_to? :url
      person.image.url(version.to_sym) 
    else
      "avatar_missing_#{version}.png"
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

  def group_name
    user_group.group.name if has_group?
  end

  def has_group?
    !user_group.nil?
  end

  def admin?
    group_name == 'admin'
  end

  def librarian?
    group_name == 'librarian'
  end

  def head?
    DepartmentHead.all.map(&:user_id).include? id
  end

  def head_adscription_id
    DepartmentHead.where(:user_id=>id).map(&:adscription_id).first if head?
  end

  def worker_key
    jobposition_log.nil? ? email : jobposition_log.worker_key
  end

  def worker_key_or_login
    worker_key.nil? ? login : worker_key
  end

  def has_contact_2?
    not (self.person.contact_name_2.nil? or self.person.contact_name_2=='')
  end

  def has_contact_3?
    not (self.person.contact_name_3.nil? or self.person.contact_name_2=='')
  end

  def students
    StudentClient.new(self.login).all
  end

  def students_url
    StudentClient.new(self.login).iframe_url
  end

  def category
    cat = category_name.to_s
    re_posdocs=Regexp.union(/posdoctoral/,/CONAC[yY]T/)
    re_researchers=Regexp.union(/[iI]nvestigador/,/^(?!.*posdoctoral).*$/)
    case
      when cat==''
        nil
      when cat.match(re_posdocs)
        category_name
      when cat.match(/cnico acad/)
        'Tecnico academico'
      when cat.match(re_researchers) #investigadores-posdocs
        'Investigador'
      else
        nil
    end
  end

  def my_projects
    pr_names = []
    up = UserProject.where(:user_id=>id).order('id DESC')
    up.each{ |pr|
      ins = '' 
      unless pr.project.institutions==[]
        pr.project.institutions.each{ |i| ins+=i.name+', ' }
        pr_names << pr.project.name+', '+pr.project.startyear.to_s+'-'+pr.project.endyear.to_s+', '+ins.to_s
      end }
    pr_names
  end

  def my_prizes
    pr_names = []
    up = UserPrize.where(:user_id=>id)
    up.each{ |pr| pr_names << pr.prize.name+', '+pr.prize.prizetype.name+', '+pr.year.to_s }
    pr_names
  end

  def my_researchlines
    rl_names = []
    researchlines.each{ |rl| rl_names << rl.id.to_s+', '+rl.name }
    rl_names
  end

  def my_lab_or_groups
    lg_names = []
    user_lab_or_groups.each{ |lg| lg_names << lg.lab_or_group.id.to_s+', '+lg.lab_or_group.name+', '+lg.lab_or_group.short_name.to_s+', '+lg.lab_or_group.url }
    lg_names
  end

  def my_knowledge_areas
    ka_names = []
    user_knowledge_areas.each{ |ka| ka_names << ka.knowledge_area.id.to_s+', '+ka.knowledge_area.name+', '+ka.knowledge_area.short_name.to_s }
    ka_names
  end

  def my_knowledge_fields
    kf_names = []
    kf_ids = []
    user_knowledge_areas.each{ |ka|
      if kf_ids.index(ka.knowledge_area.knowledge_field_id).nil?
        kf_ids << ka.knowledge_area.knowledge_field_id
        kf = ka.knowledge_area.knowledge_field
        kf_names << kf.id.to_s+', '+kf.name+', '+kf.short_name.to_s
      end
      }
    kf_names
  end

  def my_recent_articles
    arts = []
    articles.recent.each{ |ua| arts << ua.to_s+', '+ua.url.to_s }
    arts
  end

  def my_students
    stud = []
    students.each{ |st| stud << st['fullname'].to_s+', '+st['email'].to_s+', '+st['photo_url'].to_s+', '+st['period'].to_s }
    stud
  end

  def my_graduated_students
    stud = []
    theses.where(:is_verified=>true).uniq.each{ |st|
      grado = if st.degree.nil? then '' else st.degree.name end
      stud << st.authors+', '+st.title+', '+st.end_date.to_s+', '+grado }
    stud
  end

  def my_selected_books
    bks = []
    Bookedition.user_id_eq(id).authors.each{ |bk| if bk.book.is_selected then bks << bk.to_s end }
    bks
  end

  def my_selected_articles
    arts = []
    articles.each{ |ua| if ua.is_selected then arts << ua.to_s+', '+ua.url.to_s end }
    arts
  end

  def my_technical_reports
    tr_names = []
    tr = Genericwork.where(:registered_by_id=>id).technical_reports
    tr.each{ |tr| tr_names << tr.title+', '+tr.authors+', '+tr.genericworkstatus.name+', '+tr.reference.to_s+', '+tr.vol.to_s+', '+tr.pages.to_s+', '+tr.date.to_s }
    tr_names
  end

  def my_videos
    vs = []
    videos.each{ |v| vs << v.to_s }
    vs
  end

  def to_json(options={})
    { :id=>id.to_s, :login=>login, :email=>email, :fullname=>title_and_fullname, 
      :last_name=>person.lastname1.to_s+' '+person.lastname2.to_s,
      :label=>id,
      :type=>'Persona', :adscription=>adscription_name(id,Time.now.year),
      :category_name=>category_name,
      :phone=>professional_address.phone.to_s+' ext '+professional_address.phone_extension,
      :location=>professional_address.normalized_building.to_s+', '+professional_address.location.gsub(/\r/,'').strip.gsub(/\n/,', '), 
      :homepage=>homepage, :resume=>homepage_resume,
      :researchlines => my_researchlines, :category=>category,
      :lab_or_groups=>my_lab_or_groups, :knowledge_areas=>my_knowledge_areas, :knowledge_fields=>my_knowledge_fields,
      :articles=>my_recent_articles, :projects=>my_projects, :prizes=>my_prizes, :graduated_students=>my_graduated_students,
      :students=>my_students, :selected_books=>my_selected_books, :selected_articles=>my_selected_articles,
      :technical_reports =>my_technical_reports, :videos=>my_videos
    }
  end

  def as_json(options={})
    { :id=>id.to_s, :login=>login, :email=>email, :fullname=>title_and_fullname, 
      :last_name=>person.lastname1.to_s+' '+person.lastname2.to_s,
      :label=>id,
      :type=>'Persona', :adscription=>adscription_name(id,Time.now.year),
      :category_name=>category_name,
      :phone=>professional_address.phone.to_s+' ext '+professional_address.phone_extension,
      :lab_or_groups=>my_lab_or_groups, :knowledge_fields=>my_knowledge_fields, :knowledge_areas=>my_knowledge_areas
    }
  end

  def request_id_card
    jp = Jobposition.most_recent_jp(user.id)
    u_id = user.id
    a_id = jp.user_adscription.adscription_id if user.has_adscription?
    j_id = jp.id
    year = Time.now.year
    create_ldap_user(user) if User.ldap_enabled?
    UserAdscriptionRecord.create(:user_id=>u_id,:adscription_id=>a_id,:jobposition_id=>j_id,:year=>year)
    Notifier.identification_card_request(user.id).deliver
  end

  def after_updates
    if user.has_adscription? then
      year = Time.now.year
     u_id = user.id
     uar = UserAdscriptionRecord.where(:user_id=>u_id, :year=>year).first
     j_id = uar.jobposition_id
     a_id = uar.adscription_id
     uar.update_attributes(:adscription_id=>a_id,:jobposition_id=>j_id)
     ua = UserAdscription.where(:user_id=>u_id).last
     ua.update_attributes(:adscription_id=>a_id)
   end
   if user.userstatus_id_changed?
     Notifier.updated_userstatus_to_admin(user.id).deliver
   end
   if !user.password.nil? and User.ldap_enabled?
     update_ldap_user(user)
   end
   if user.has_image? and user.person.image.changed? and User.aleph_enabled?
     create_or_update_aleph_account(user)
   end
  end

  def destroy_connected_users
    destroy_ldap_user(user) if User.ldap_enabled?
    destroy_aleph_user(user) if User.aleph_enabled?
  end

end
