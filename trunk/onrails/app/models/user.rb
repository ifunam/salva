# This is a forked work from the Security Model implemented by Bruce Perens:
# http://perens.com/FreeSoftware/ModelSecurity/

# A generic user login facility. Provides a user login, password
# management, and administrative facilities. Logs users in via SESSION
# authentication, a login form, or a security token. Maintains the login
# state using Session.
#
# I started out with the Salted Hash login generator, and essentially rewrote
# the whole thing, learning a lot from the previous versions. This is not a
# criticism of the previous work, my goals were different. So, it's fair to
# say that this is derived from the work of Joe Hosteny and Tobias Leutke.
#
require 'digest/sha2'
require 'model_security'

class User < ActiveRecord::Base
  # This causes the security features to be added to the model.
  include ModelSecurity

private
  attr_accessible :login, :email, :password, :password_confirmation, \
   :old_password

  # Hash a given password with the salt. This method localizes the encryption
  # function so that it can be easily changed.
  def encypher(s)
    Digest::SHA512.hexdigest(salt + s)
  end

  # Create a new user record.
  #
  # This is either used to create an ephemeral prototype object to initialize
  # a form, or an object resulting from a form submission that will become a
  # persistent record.
  #
  def initialize(attributes = nil)
    super

    if password
      @password_is_new = true
    end
  end

  # Returns true if it is intended that the password be replaced when this
  # record is saved.
  def password_new?
    @password_is_new
  end

  Char64 = (('a'..'z').collect + ('A'..'Z').collect + ('0'..'9').collect + ['.','/']).freeze

  # Create a security token for use in logging in a user who has forgotten
  # his password or has just created his login.
  def token_string(n)
    s = ""
    n.times { s << Char64[(Time.now.tv_usec * rand) % 64] }
    s
  end

  # Validates that initialize() sets @password_is_new to true, so that
  # password validation works correctly. This would fail only in the case 
  # of a programming error.
  def validate_on_create
    password_new?
  end

  # Validates that if we're changing the password or email, the old password
  # has been given and matches the record. This is a defense against
  # cookie-capture attacks.
  def validate_on_update
    if not (id.nil? or User.admin?) and (password_new? or @email_is_new)
      if encypher(old_password) != passwd
        errors.add(:old_password, "The old password doesn't match.")
        return false
      end
    end
    true
  end

  before_save :prepare_save

  validates_presence_of :login
  validates_uniqueness_of :login
  validates_uniqueness_of :email
  validates_format_of :email, \
   :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  validates_presence_of :password, :if => :password_new?
  validates_presence_of :password_confirmation, :if => :password_new?
  validates_length_of :login, :within => 3..80
  validates_length_of :password, :within => 5..128, :if => :password_new?
  validates_confirmation_of :password, :if => :password_new?

  # Here are the new model security specifications. 

  # These just control display.
  let_display :all, :if => :never?
  let_display :admin, :userstatus_id, :if => :admin?
  let_display :login, :email

  # These control both reading and writing.

  # Let the administrator access all data. This implements a Unix-like
  # super-user. Note that the coarse-grained override of the super-user
  # is not a _necessary_ pattern for the ModelSecurity module, you can
  # implement controls as fine-grained as you like.
  let_access :all, :if => :admin?

  # These control reading of model attributes.

  # The controller before_filter require_admin tests if the current user
  # is the administrator, thus we have to make the admin attribute readable
  # by all. We would not have to make it readable were admin? only being
  # used as a security test, as security tests can access all attributes
  # with impunity. Login and name are public information.
  #
  let_read :admin, :login, :name

  # Allow the very first user to be promoted to administrator.
  # Once there's an admin, that user has "let_access :all" and can
  # promote others to administrator.
  let_write :admin, :if => :initial_self_promotion?
  
  # If this is a new (never saved) record, or if this record corresponds to
  # the currently-logged-in user, allow reading of the email address.
  let_read :email, :if => :new_or_me_or_logging_in?

  # These attributes are concerned with login security, and can only be read
  # while a user is logging in. We create a pseudo-user for the process of= 1
  # logging in and a security test :logging_in? that tests for that user.
  let_read :userstatus_id, :passwd, :salt, :token, :token_expiry, :pkcs7, \
   :if => :logging_in?

  # These control writing of model attributes.

  # Only in the case of a new (never saved) record can these fields be written.
  #
  let_write :login, :if => :new_record?

  # Only allow this information to be updated by the user who owns the record,
  # unless this record is new (has never been saved).
  let_write :passwd, :email, :salt, :if => :new_or_me?

  
  # The security token can only be changed if we're the special "login" user.
  let_write :userstatus_id, :token, :token_expiry, :if => :logging_in?

  public
  attr_accessor :password, :password_confirmation, :old_password

  # NOTE: :password, :password_confirmation, and :old_password
  # are not attributes of the record, they are instance variables of the
  # class and aren't written to disk under those names. But I declare them
  # here because otherwise ModelSecurityHelper (which doesn't know that)
  # isn't going to allow me to enter them into a form field.
  #
  # I like how fine-grained I can get.
  let_write :password, :if => :new_or_me_or_logging_in?
  let_write :password_confirmation, :if => :new_or_me?
  let_write :old_password, :if => :me?

  # Return the user for the current request. It is guaranteed that this is
  # set for each request in the before_filter for the application.
  #
  # This function uses the Ruby Thread class to do thread-local storage,
  # which will be overkill if the Rails server implementation isn't also
  # using Ruby threads, but works everywhere.
  #
  # User.current(), User.current=(), and UserSupport#user_setup encapsulate
  # session storage of user information. Only these three functions should
  # know whether we store the entire User object in the session or only
  # User#id.
  #
  def User.current
    # This does not refer to the session because the application has set
    # this from the session in user_setup.
    Thread.current[:user]
  end

  # Set the user for the current request. It is guaranteed that this is
  # set for each request in the before_filter for the application.
  #
  # This function uses the Ruby Thread class to do thread-local storage,
  # which will be overkill if the Rails server implementation isn't also
  # using Ruby threads, but works everywhere.
  #
  # User.current(), User.current=(), and UserSupport#user_setup encapsulate
  # session storage of user information. Only these three functions should
  # know whether we store the entire User object in the session or only
  # User#id.
  #
  def User.current=(u)
    Thread.current[:user] = u

    session = Thread.current[:session]

    if session.nil?
      message = "Programming error: Please add \"before_filter :user_setup\" to your application controller. See the ModelSecurity documentation."

      raise RuntimeError.new(message)
    end

    # Don't cause a session store unnecessarily
    if session[:user] != u
      session[:user] = u
    end
  end

  # Change the user's password. Confirm the old password while doing so.
  def change_password(attributes)
    @password_is_new = true
    self.password = attributes['password']
    self.password_confirmation = attributes['password_confirmation']
    self.old_password = attributes['old_password']
  end

  # Change the user's email address.
  # FIX: send confirmation email.
  def change_email(attributes)
    @email_is_new = true
    self.email = attributes['email']
    self.old_password = attributes['old_password']
  end

  # Return true if this record corresponds to the currently-logged-in user.
  # This is used as a security test.
  def me?
    u = User.current
    u and u.id == id
  end

  # Return true if the currently-logged-in user is the administrator.
  # Class method. This is used as a pseudo-security test by let_display.
  def User.admin?
    user = User.current
    if user 
      g = UsersGroups.find(:first, :conditions => 
                             [ "user_id = ? AND group_id = ?", user.id, 1])
      return ((g != nil ) and (g.group_id.to_i == 1))
    end
  end

  # Return true if the currently-logged-in user is the administrator.
  # Instance method. This is used as a security test.
  def admin?
    return User.admin?
  end

  # Return true if the user's ID is 1 and the user is attempting to promote
  # himself to administrator. This is used to bootstrap the first administrator
  # and for no other purpose.
  def initial_self_promotion?
    return ((id == 1) and (not admin?) and (self.class.count == 1))
  end

  # Return true if the user is currently logging in. This security test allows
  # us to designate model fields to be visible *only* while a user is logging
  # in.
  def logging_in?
    # FIX: create a real login user.
    return User.current.nil?
  end

  def User.login_user
    # FIX: create a real login user.
    nil
  end

  # Return true if the user record is new (never been saved) or if it
  # corresponds to the currently-logged-in user. This security test is
  # a common pattern applied to a number of user record attributes.
  def new_or_me?
    new_record? or User.current == self
  end

  # Return true if the user record is new (never been saved) or if it
  # corresponds to the currently-logged-in user, or if the current user
  # is the special "login" user. This security test is a common pattern
  # applied to a number of user record attributes.
  def new_or_me_or_logging_in?
    new_record? or User.current == self or logging_in?
  end

  # Create a new security token, or if the current one is not yet expired,
  # return the current one. Should only be called with nobody logged in, it
  # will log out the current user if one is logged in.
  # Instance method.
  def new_token
    User.current = User.login_user
    if token == '' or token_expiry < Time.now
      self.token = token_string(10)
      self.token_expiry = 7.days.from_now
      result = save
    end
    User.current = nil
    return token
  end

  # Create a new security token, or if the current one is not yet expired,
  # return the current one. Should only be called with nobody logged in, it
  # will log out the current user if one is logged in.
  # Class method.
  def User.new_token(address)
    u = User.find_first(['email = ?', email])
    u.new_token
  end

  # Encrypt the password before saving. Then wipe out the provided plaintext
  # password, so that it won't trigger unnecessary security tests and
  # validations the next time this record is saved. Wiping out the plaintext
  # is more secure, anyway.
  def prepare_save
    # The salt is used to add a random factor to the plaintext. This might
    # make some cryptographic attacks more difficult.
    if password_new?
      self.salt = token_string(40)
      self.passwd = encypher(password)

      self.password = nil
      self.password_confirmation = nil
      @password_is_new = nil
    end
    true
  end

  # Log off the current user.
  def User.sign_off
    User.current = nil
  end

  # Log on the user for this record, given a password. Instance method.
  def sign_on(pass)
    User.current = User.login_user
    begin
      if (userstatus_id == 2) and (pass != nil) and (encypher(pass) == passwd)
        return (User.current = self)
      end
    rescue
    end
    User.current = nil
  end

  # Log on the user for this record, given a user name and password.
  # Class method.
  def User.sign_on(handle, pwd)
    user = find_first(['login = ?', handle])
    if user
      user.sign_on(pwd)
    else
      nil
    end
  end

  # Sign on the user using a security token. Instance method.
  def sign_on_by_token(t)
    User.current = User.login_user
    if t == token and (token_expiry >= Time.now)
      self.token = ""
      self.token_expiry = Time.now
      self.userstatus_id = 2
      save
      User.current = self
      return self;
    end
    return nil
  end

  # Sign on the user using an ID (record index) and security token.
  # Class method.
  def User.sign_on_by_token(id, token)
    u = User.find(id)
    return u.sign_on_by_token(token)
  end
end
