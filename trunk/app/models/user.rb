class User < ActiveRecord::Base
  include Digest
  belongs_to :userstatus
  # attr_accessible :email, :login, :passwd
  
  validates_presence_of     :login, :email, :passwd
  validates_uniqueness_of   :login, :email
  validates_length_of       :login, :within => 3..20
  validates_length_of       :email, :within => 3..100
  validates_length_of       :passwd,:within => 5..200, :allow_nil => true
  validates_confirmation_of :passwd
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  
  before_create :prepare_new_record
  before_update :prepare_new_record

  after_validation_on_create :prepare_password  
  after_create :clean_password

  private
  def prepare_new_record
    # New userstatus and preparing the tokens for the account activation process
    # The salt is used to add a random factor to the plaintext. This might
    # make some cryptographic attacks more difficult.
    self.userstatus_id = 1
    self.token = token_string(10)
    self.token_expiry = 7.days.from_now
  end
  
  def prepare_password
    #if new_record?
      if self.passwd
        self.salt = salted
        self.passwd = encrypt(self.passwd, self.salt) 
        self.passwd_confirmation = nil    
      end
    #end
  end
  
  def clean_password
    self.passwd = nil
  end
  
end
