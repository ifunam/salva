require File.dirname(__FILE__) + '/../test_helper'

class UserNotifierTest < ActionMailer::TestCase
  tests UserNotifier
  fixtures :userstatuses, :users
  
  def test_new_notification
    response = UserNotifier.create_new_notification(User.last) 
    assert_equal("[SALVA] Su cuenta ha sido creada, por favor activela...", response.subject) 
    assert_equal("john.smith@nodomain.com", response.to[0]) 
    assert_match(/creada/, response.body) 
  end 
  
  def test_activation
    response = UserNotifier.create_activation(User.last) 
    assert_equal("[SALVA] Su cuenta ha sido activada", response.subject) 
    assert_equal("john.smith@nodomain.com", response.to[0]) 
    assert_match(/activada/, response.body) 
  end
  
  def test_password_recovery
    response = UserNotifier.create_password_recovery(User.first) 
    assert_equal("[SALVA] Información para cambiar la contraseña de su cuenta", response.subject) 
    assert_equal("alex@fisica.unam.mx", response.to[0]) 
    assert_match(/login_by_token/, response.body) 
  end
end
