class Notifier < ActionMailer::Base
  include Resque::Mailer

  default :from => "salva@fisica.unam.mx"

  def new_user_to_admin(user_id)
    @user =  User.find(user_id)
    mail(:to => 'alex@fisica.unam.mx', :cc => 'vic@fisica.unam.mx, cuentas@fisica.unam.mx',
         :subject => 'SALVA - Nuevo usuario') do |format|
      format.text
    end
  end

  def ldap_errors_to_admin(user_id)
    @user = User.find(user_id)
    mail(:to => 'vic@fisica.unam.mx', :cc => 'alex@fisica.unam.mx',
         :subject => 'SALVA - Errores al crear usuario en LDAP') do |format|
      format.text
    end
  end

  def deleted_user_to_admin(login)
    @login = login
    mail(:to => 'alex@fisica.unam.mx', :cc => 'vic@fisica.unam.mx, cuentas@fisica.unam.mx',
         :subject => 'SALVA - Usuario borrado') do |format|
      format.text
    end
  end

  def updated_userstatus_to_admin(user_id)
    @user =  User.find(user_id)
    mail(:to => 'alex@fisica.unam.mx', :cc => 'vic@fisica.unam.mx, cuentas@fisica.unam.mx',
         :subject => 'SALVA - Estado de usuario actualizado') do |format|
      format.text
    end
  end

  # TODO: Implement the welcome message for new users
end
