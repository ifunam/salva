require 'digest/sha1'
module LDAP
  class User
    include ActiveModel::Validations
    include ActiveModel::Serialization
    include ActiveModel::MassAssignmentSecurity
    include ActiveModel::Dirty
    extend  ActiveModel::Translation

    attr_accessor :login, :fullname, :email, :password, :group, :new_record
    attr_accessible :login, :fullname, :email, :password, :group
    validates_presence_of :login, :fullname, :email, :password, :group
    validates_confirmation_of :password

    def self.all_by_login_like(login)
      filter = Net::LDAP::Filter.eq("uid", "*#{login.downcase}*")
      self.ldap.search(:base => ldap_config['base'], :filter => filter, :return_result => true).collect do |entry|
        entry_to_record(entry)
      end
    end

    def self.find_by_login(login)
      entry = self.ldap.search(:base => ldap_config['base'], :filter => Net::LDAP::Filter.eq("uid", login), :return_result => true ).first
      entry_to_record(entry) unless entry.nil?
    end

    def self.uid_exist?(uid)
      !self.find_by_login(uid).nil?
    end

    def self.ldap
      Net::LDAP.new(:host => ldap_config['host'], :port => ldap_config['port'], :encryption => (ldap_config['ssl'] ? :simple_tls : nil),
                    :auth => { :method => :simple, :username => ldap_config['admin_user'], :password => ldap_config['admin_password'] })
    end

    def self.ldap_config
      YAML.load(ERB.new(File.read("#{Rails.root}/config/ldap.yml")).result)[Rails.env]
    end

    def self.entry_to_record(entry)
      new(:login => entry.uid.first, :email => entry.mail.first, :fullname => entry.cn.first, :password => entry.userpassword.first, :group => entry.ou.first, :new_record => false)
    end

    def initialize(attributes={})
      if attributes.has_key? :new_record
        self.new_record = attributes[:new_record] 
        attributes.delete(:new_record)
      else
        self.new_record = true
      end
      self.attributes=(attributes)
      self
    end

    def attributes=(hash)
      sanitize_for_mass_assignment(hash).each do |attribute, value|
        send("#{attribute}=", value)
      end
    end

    def save
      if valid?
        new_record? ? create : update
      else
        false
      end
    end

    def create
      unless LDAP::User.uid_exist?(login)
        LDAP::User.ldap.add(:dn => ldap_dn, :attributes => ldap_attributes)
        self.new_record = false
        return true
      end
      return false
    end

    def update
      if LDAP::User.uid_exist?(login)
        LDAP::User.ldap.modify(:dn => ldap_dn, :attributes => ldap_attributes)
        return true
      end
      return false
    end

    def destroy
      LDAP::User.ldap.delete(:dn => ldap_dn) unless new_record?
    end

    private
    def new_record?
      self.new_record
    end

    def ldap_attributes
      {
        :objectClass => ldap_object_class,
        :cn => fullname,
        :sn => 'sn',
        :mail => email,
        :ou => group,
        :uid => login,
        :userPassword => Net::LDAP::Password.generate(:sha, password)
      }
    end

    def ldap_dn
      "uid=#{login},#{LDAP::User.ldap_config['base']}"
    end

    def ldap_object_class
      LDAP::User.ldap_config['require_attribute']['objectClass'].split(',').collect {|object_class_name| object_class_name.strip }
    end
  end
end
