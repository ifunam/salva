module LDAP
  module Helpers  
    module UserModel
      def ldap_enabled?
        File.exist? File.join(Rails.root.to_s, 'config', 'ldap.yml')
      end

      private
      def ldap_users_like(login)
        LDAP::User.all_by_login_like(login.downcase).collect { |user|
          new(:login => user.login, :email => user.email) unless ::User.exists?(:login => user.login)
        }.compact
      end
    end
  end
end
