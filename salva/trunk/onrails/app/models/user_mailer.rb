ActionMailer::Base.delivery_method = :sendmail

# Send mail to a user to administer that user's login. Called by UserController.
class UserMailer < ActionMailer::Base
  private
  def set_sender
    s = 'salva@salva.fisica.unam.mx'
  end
  
  
  public
  # Send a forgot-password email, allowing the user to regain their login name
  # and password.
  def forgot_password(user, url)
    @body['params'] = user
    @body['url'] = url
    
    recipients	user.email
    subject	'Información para cambiar la contraseña de su cuenta en el SALVA'
    set_sender
  end
  
  # Send a new-user email, providing the user with a URL used to validate
  # that user's login.
  def new_user(params, url, token_expiry)
    @body['params'] = params
    @body['url'] = url
    @body['token_expiry'] = token_expiry

    recipients	params['email']
    subject	'Su cuenta en el salva ha sido creada.'
    set_sender
  end
end
