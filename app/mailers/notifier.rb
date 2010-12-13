class Notifier < ActionMailer::Base
  include Resque::Mailer

  default :from => "salva@fisica.unam.mx"

  def new_user_to_admin(user_id)
    @user =  User.find(user_id)
    mail(:to => 'sac-if@fisica.unam.mx', :cc => 'vic@fisica.unam.mx, cuentas@fisica.unam.mx',
         :subject => 'SALVA - Nuevo usuario') do |format|
      format.text
    end
  end

  def identification_card_request(user_id)
    @user =  User.find(user_id)
    mail(:to => 'cd-if@fisica.unam.mx', :cc => 'cuentas@fisica.unam.mx',
         :subject => 'SALVA - Nuevo usuario') do |format|
      format.text
    end
  end

  def ldap_errors_to_admin(user_id)
    @user = User.find(user_id)
    mail(:to => 'vic@fisica.unam.mx', :cc => 'sac-if@fisica.unam.mx',
         :subject => 'SALVA - Errores al crear usuario en LDAP') do |format|
      format.text
    end
  end

  def deleted_user_to_admin(login)
    @login = login
    mail(:to => 'sac-if@fisica.unam.mx', :cc => 'vic@fisica.unam.mx, cuentas@fisica.unam.mx',
         :subject => 'SALVA - Usuario borrado') do |format|
      format.text
    end
  end

  def updated_userstatus_to_admin(user_id)
    @user =  User.find(user_id)
    mail(:to => 'sac-if@fisica.unam.mx', :cc => 'vic@fisica.unam.mx, cuentas@fisica.unam.mx',
         :subject => 'SALVA - Estado de usuario actualizado') do |format|
      format.text
    end
  end
  
  def approved_document(document_id)
    @document = Document.find(document_id)
    build_document(document_id, received=false)
    mail(:to => @document.user.email, :cc => ['salva@fisica.unam.mx', @document.approved_by.email],
         :subject => @document.documenttype.name) do |format|
      format.text
      attachments[filename] = @document.file if File.exist? @document.file
    end
  end

  def approval_request_from_user(document_id)
    @document = Document.find(document_id)
    build_document(document_id, received=false)
    mail(:to => @document.approved_by.email, :cc => 'salva@fisica.unam.mx',
         :subject => @document.documenttype.name) do |format|
      format.text
      attachments[filename] = @document.file if File.exist? @document.file
    end
  end
  
  def approval_request_to_user_incharge(document_id)
    @document = Document.find(document_id)
    mail(:to => @document.user.email, :cc => 'salva@fisica.unam.mx',
         :subject => @document.documenttype.name) do |format|
      format.text
      attachments[filename] = @document.file if File.exist? @document.file
    end
  end
  
  def rejected_document(document_id)
    @document = Document.find(document_id)
    mail(:to => @document.user.email, :cc => ['salva@fisica.unam.mx', @document.approved_by.email],
         :subject => @document.documenttype.name)
  end
  
  private
  # FIX IT: Move this method into a new Worker Class
  def build_document(document_id, received=false)
    @document = Document.find(document_id)
    @report = UserAnnualReport::Base.find(@document.user_id, @document.documenttype.year)
    @report.code = @document.ip_address
    @report.signature = Digest::MD5.hexdigest(@document.file)
    @report.received = true if @document.approved?
    @report.save_pdf(@document.file)
  end

  # TODO: Implement the welcome message for new users
end
