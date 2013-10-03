module LDAP
  module Helpers  
    module UserObserver
      def create_ldap_user(user)
          @user = User.find(user.id)
          category_name = @user.category_name || 'N'
          @ldap_user = LDAP::User.new(:login => @user.login, :group => @user.adscription_abbrev, :fullname => @user.fullname_or_email, 
                                      :email => @user.email, :password => user.password, :password_confirmation => user.password,
                                      :title => category_name
                                     )
          if @ldap_user.valid? and @ldap_user.save
            Notifier.new_user_to_admin(user.id).deliver
          else
            Notifier.ldap_errors_to_admin(user.id).deliver
          end
      end

      def update_ldap_user(user)
        @ldap_user = LDAP::User.find_by_login(user.login)
        category_name = @user.category_name || 'N'
        if @ldap_user.update_attributes(:login => user.login, :group => user.adscription_abbrev, :fullname => user.fullname_or_email,
                                        :email => user.email, :password => user.password, :password_confirmation => user.password,
                                        :title => category_name
                                       )
           # Notifier.updated_user_to_admin(user.id).deliver
        end
      end

      def destroy_ldap_user(user)
        @ldap_user = LDAP::User.find_by_login(user.login)
        if !@ldap_user.nil? and @ldap_user.destroy
          Notifier.deleted_user_to_admin(user.login).deliver
        end
      end
    end
  end
end
