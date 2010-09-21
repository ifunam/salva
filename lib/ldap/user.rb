require 'net/ldap'
module LDAP
  module Connection
    def ldap_config
      @config ||= YAML.load(ERB.new(File.read("#{Rails.root}/config/ldap.yml")).result)[Rails.env]
    end

    def ldap_connection_config
      { 
        :host => ldap_config['host'], :port => ldap_config['port'], :encryption => (ldap_config['tls'] ? :simple_tls : nil),
        :auth => { :method => :simple, :username => ldap_config['username'], :password => ldap_config['password'] }
      }
    end
    def ldap_connection
      Net::LDAP.new ldap_connection_config
    end
  end
  
  class User
    include ActiveModel::Validations
    include ActiveModel::Serialization
    include ActiveModel::MassAssignmentSecurity
    include ActiveModel::Dirty
    include LDAP::Connection

    extend  ActiveModel::Translation
    extend LDAP::Connection

    
    attr_accessor :login, :group, :fullname, :email, :password
    attr_accessible :login, :group, :fullname, :email, :password
    define_attribute_methods [:login, :group, :fullname, :email, :password]

    validates_presence_of :login, :group, :fullname, :email, :password
    validates_confirmation_of :password

    def self.find_all_by_login(login)
      filter = Net::LDAP::Filter.eq( "uid", login.downcase)
      ldap_connection.search(:base => ldap_config['base'], :attributes => { :uid => login.downcase }, :filter => filter, :return_result => true )
    end

    def initialize(attributes={})
      @new_record = true
      attributes=(attributes)
      self
    end

    def attributes=(values)
      sanitize_for_mass_assignment(values).each do |k, v|
        send("#{k}=", v)
      end
    end

    def save
      if valid? 
        if new_record?
          create
        else
          update
        end
      else
        false
      end
    end

    def destroy
      ldap_connection.delete(:dn => dn) unless new_record?
    end

    def new_record?
      @new_record
    end

    private

    def create
      unless uid_exist?(login)
        ldap_connection.add(:dn => dn, :attributes => attributes)
        @new_record = false
        true
      else
        false
      end
    end

    def update
      if uid_exist?(login_was)
        ldap_connection.modify(:dn => "uid=#{login_was},ou=#{group},#{ldap_config['base']}", :attributes => attributes)
        true
      else
        false
      end
    end

    def uid_exist?(uid)
      filter = Net::LDAP::Filter.eq( "uid", uid)
      ldap_connection.search(:base => ldap_config['base'], :attributes => { :uid => uid }, :filter => filter, :return_result => true ).size > 0
    end

    def dn
      "uid=#{login},ou=#{group},#{ldap_config['base']}"
    end

    def attributes
      { 
        :objectClass => ["inetOrgPerson", "organizationalPerson", "person", "top"],
        :cn => fullname,
        :sn => 'sn',
        :mail => email,
        :ou => group,
        :uid => login,
        :userPassword => password
      } 
    end
  end
end