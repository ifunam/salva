class Notifier < ActionMailer::Base
  include Resque::Mailer

  default :from => "salva@fisica.unam.mx"

  def new_user_to_admin(user)
    # You should resist the temptation to pass database-backed objects as parameters 
    # in your mailer and instead pass record identifiers, because database objects 
    # couldn't be handled by Resque and Redis
    @user =  hash_to_record(user)
    mail(:to => 'alex@fisica.unam.mx', :cc => 'vic@fisica.unam.mx, cuentas@fisica.unam.mx',
         :subject => 'SALVA - Nuevo usuario') do |format|
      format.text
    end
  end

  def ldap_errors_to_admin(user)
    @user = hash_to_record(user)
    mail(:to => 'vic@fisica.unam.mx', :cc => 'alex@fisica.unam.mx',
         :subject => 'SALVA - Errores al crear usuario en LDAP') do |format|
      format.text
    end
  end

  def deleted_user_to_admin(record)
    @user = (record.is_a? Hash) ? User.new(:login => record['user']['login']) : record
    mail(:to => 'alex@fisica.unam.mx', :cc => 'vic@fisica.unam.mx, cuentas@fisica.unam.mx',
         :subject => 'SALVA - Usuario borrado') do |format|
      format.text
    end
  end

  def hash_to_record(record)
    (record.is_a? Hash) ? User.find(record['user']['id']) : record
  end
  # TODO: Implement the welcome message for new users
end
