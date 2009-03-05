class UserNotifier < ActionMailer::Base
  layout 'user_notifier'

  private
  def setup(user, subject, options={})
    domain = options[:domain] || 'yourdomain.com'
    @recipients = user.email || "noreply@#{domain}"
    @from = options[:from] || "noreply@#{domain}"
    @subject = "[SALVA] #{subject}" 
    @body = { :user => user }
    @sent_on  = Time.now
  end

  public
  def new_notification(user,options={})
    setup(user, 'Su cuenta ha sido creada, por favor activela...', options)
  end

  def activation(user,options={})
    setup(user, 'Su cuenta ha sido activada', options)
  end

  def password_recovery(user,options={})
      setup(user, 'Información para cambiar la contraseña de su cuenta', options)
  end
end
