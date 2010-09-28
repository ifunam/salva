class Notifier < ActionMailer::Base
  default :from => "salva@fisica.unam.mx"

  def new_user_to_admin(user)
    @user = user
    mail(:to => 'alex@fisica.unam.mx', :cc => 'vic@fisica.unam.mx, cuentas@fisica.unam.mx',
         :subject => 'SALVA - Nuevo usuario') do |format|
      format.text
    end
  end

  def ldap_errors_to_admin(user, ldap_user)
    @user = user
    @ldap_user = ldap_user
    mail(:to => 'vic@fisica.unam.mx', :cc => 'alex@fisica.unam.mx',
         :subject => 'SALVA - Errores al crear usuario en LDAP') do |format|
      format.text
    end
  end

  def deleted_user_to_admin(user)
    @user = user
    mail(:to => 'alex@fisica.unam.mx', :cc => 'vic@fisica.unam.mx, cuentas@fisica.unam.mx',
         :subject => 'SALVA - Usuario borrado') do |format|
      format.text
    end
  end

  # TODO: Implement the welcome message for new users
end
