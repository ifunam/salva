require 'digest/sha2'
require 'resolv'
class User < ActiveRecord::Base
  attr_accessor :current_passwd
  validates_presence_of     :login, :email, :passwd
  validates_length_of       :login, :within => 3..30
  validates_length_of       :email, :within => 7..100
  validates_length_of       :passwd, :within => 5..200, :allow_nil => true
  validates_confirmation_of :passwd
  #validates_presence_of     :passwd_confirmation, :if => :passwd_changed?
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  validates_format_of       :login, :with =>  /\A[-a-z0-9\.\-\_]*\Z/
  #validates_email_veracity_of :email # Depends on internet connectivity and right configuration of your dns
  validates_uniqueness_of   :login
  validates_uniqueness_of   :email
  validates_uniqueness_of   :login, :scope => [:email]

  named_scope :unactivated, :conditions => { :userstatus_id => 1 }
  named_scope :activated, :conditions => { :userstatus_id => 2 }
  named_scope :locked, :conditions => { :userstatus_id => 3 }
  named_scope :in_history_file, :conditions => { :userstatus_id => 4 }
  named_scope :with_user_incharge, :conditions => 'user_incharge_id IS NOT NULL'

  belongs_to :userstatus
  belongs_to :user_incharge, :class_name => 'User', :foreign_key => 'user_incharge_id'

  has_one :person
  has_one :photo

  # Callbacks
  before_create :prepare_new_record
  after_validation_on_create  :encrypt_password
  before_validation_on_update :verify_current_password
  
  # Static or class methods
  def self.authenticate?(login,password)
    @user = User.find_by_login(login)
    !@user.nil? and !@user.salt.nil? and @user.passwd == User.encrypt(password, @user.salt) and @user.is_activated? ? true : false
  end

  def self.authenticate_by_token?(login,token)
    User.find_by_login_and_token(login,token).nil? ? false : true 
  end

  def self.find_by_valid_token(id,token) 
    User.find_by_id_and_token(id, token, :conditions => [ 'token_expiry >= ?', Date.today])
  end
  
  def self.change_password(login, current_pw, new_pw)
    record = User.find_by_login(login)
    record.current_passwd = current_pw
    record.passwd = new_pw
    record.save if record.valid?
  end

  def self.encrypt(password, mysalt)
    Digest::SHA512.hexdigest(password + mysalt)
  end

  # Instance methods
  def activate
    change_userstatus(2)
  end

  def lock
    change_userstatus(3)
  end

  def send_to_history_file
    change_userstatus(4)
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

  def is_unactivated?
    self.userstatus_id == 1
  end

  def is_activated?
    self.userstatus_id == 2
  end

  def is_locked?
    self.userstatus_id == 3
  end

  def is_in_history_file?
    self.userstatus_id == 4
  end

  protected
  def prepare_new_record
    self.userstatus_id = 1
    self.token = token_string(10)
    self.token_expiry = 7.days.from_now
  end

  def encrypt_password
    if self.passwd != nil
      self.salt = token_string(40)
      plaintext = passwd
      self.passwd = User.encrypt(plaintext, self.salt)
      self.passwd_confirmation = nil
    end
  end

  def verify_current_password
    if !self.current_passwd.nil? and User.find(self.id).passwd != User.encrypt(self.current_passwd, self.salt)
        errors.add("passwd", "is not valid")
        return false
    end
    if !self.passwd_confirmation.nil? and self.passwd != self.passwd_confirmation
        errors.add("passwd", "doesn't match confirmation")
        return false
    end
    encrypt_password if passwd_changed?
  end

  def change_userstatus(status)
    self.userstatus_id = status
    save(true)
  end

  def token_string(n)
    if n.to_i > 1
      s = ""
      char64 = (('a'..'z').collect + ('A'..'Z').collect + ('0'..'9').collect + ['.','/']).freeze
      n.times { s << char64[(Time.now.tv_usec * rand) % 64] }
      s
    end
  end
end
