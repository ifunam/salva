class User < ActiveRecord::Base
  include Mydigest

  attr_accessor :current_passwd

  validates_presence_of     :login, :email, :passwd
  validates_uniqueness_of   :login, :email
  validates_length_of       :login, :within => 3..30
  validates_length_of       :email, :within => 7..100
  validates_length_of       :passwd,:within => 5..200, :allow_nil => true
  validates_confirmation_of :passwd
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  validates_format_of       :login, :with =>  /\A[-a-z0-9\.]*\Z/

  belongs_to :userstatus
  belongs_to :user_incharge, :class_name => "User", :foreign_key => "user_incharge_id"

  has_one :person
  has_many :addresses

  has_many :citizens
  has_many :people_identifications
  has_many :identifications, :through => :people_identifications

  has_many :schoolings, :order => 'schoolings.startyear, schoolings.endyear ASC'

  has_many :user_articles
  has_many :articles, :through => :user_articles

  has_many :user_genericworks
  has_many :teachingproducts, :through => :user_genericworks #,  :include => [:genericwork], :source => :user, :conditions => 'genericworks.genericworkgroup_id = 4 AND genericworks.genericworktype_id = genericworktypes.id'

  has_many :user_proceedings
  has_many :proceedings, :through => :user_proceedings

  has_many :user_inproceedings
  has_many :inproceedings, :through => :user_inproceedings


  has_many :user_documents
  has_many :documents, :through => :user_documents

  has_many :user_stimuluses
  has_many :stimuluses, :through => :user_stimuluses

  # Callbacks
  before_create :prepare_new_record
  after_validation_on_create :encrypt_password
  before_validation_on_update :verify_current_password

  # UserStatus handling

  def activate
    change_userstatus({ :userstatus_id => 2 , :token => nil})
  end

  def locked
    change_userstatus({ :userstatus_id => 3 })
  end

  def reject
    change_userstatus({ :userstatus_id => 4 })
  end

  def is_activated?
    self.userstatus_id == 2 # Look for approved or activated status in the userstatuses catalog.
  end

  def is_locked?
    self.userstatus_id == 3 # Look for locked or inactivated status in the userstatuses catalog.
  end

  def is_rejected?
    self.userstatus_id == 4 # Look for rejected status in the userstatuses catalog.
  end

  def is_in_history_file?
    self.userstatus_id == 5 # Look for history file or 'Archivo muerto' status in the userstatuses catalog.
  end

  def has_user_incharge?
    !self.user_incharge_id.nil?
  end

  def new_token
    self.token = token_string(10)
    self.token_expiry = 7.days.from_now
    save(true)
  end

  def destroy_token
    self.token = nil
    self.token_expiry = nil
    save(true)
  end

  private
  def prepare_new_record
    # New userstatus and preparing the tokens for the account activation process
    # The salt is used to add a random factor to the plaintext. This might
    # make some cryptographic attacks more difficult.
    self.userstatus_id = 1

    self.token = token_string(10)
    self.token_expiry = 7.days.from_now
  end

  def encrypt_password
    if self.passwd != nil
      self.salt = salted
      self.passwd = encrypt(self.passwd, self.salt)
      self.passwd_confirmation = nil
    end
  end

  def verify_current_password
    if self.current_passwd != nil
      if User.find(:first, :conditions => ["id = ?", self.id]).passwd == encrypt(self.current_passwd, self.salt)
        encrypt_password
      else
        errors.add("current_passwd", "is not valid")
        return false
      end
    end
  end

  def change_userstatus(myattributes)
    self.attributes = myattributes
    save(true)
  end
end
