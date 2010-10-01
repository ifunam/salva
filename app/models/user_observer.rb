class UserObserver < ActiveRecord::Observer
  def after_create(user)
    @new_user = User.find(user.id)
    @ldap_user = LDAP::User.new(:login => @new_user.login, :group => @new_user.adscription_abbrev, :fullname => @new_user.fullname_or_email, 
                                :email => @new_user.email, :password => user.password, :password_confirmation => user.password)
    if @ldap_user.valid?
      @ldap_user.save
      Notifier.new_user_to_admin(@new_user.id).deliver
    else
      Notifier.ldap_errors_to_admin(@new_user.id).deliver
    end
  end
  
  def before_update(user)
    Notifier.updated_userstatus_to_admin(user.id).deliver if user.userstatus_id_changed?
    # TODO: Add LDAP code to update the user status 
  end
  
  def after_destroy(user)
    @ldap_user = LDAP::User.find_by_login(user.login)
    @ldap_user.destroy unless @ldap_user.nil?
    Notifier.deleted_user_to_admin(user.login).deliver
  end
end
