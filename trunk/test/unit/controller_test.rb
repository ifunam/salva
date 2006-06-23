require File.dirname(__FILE__) + '/../test_helper'

class ControllerTest < Test::Unit::TestCase
  fixtures :controllers

  def test_should_create_controller
    assert create_controller.valid?
  end

  def test_should_require_login
    u = create_controller(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_controller(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_controller(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_controller(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    controllers(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal controllers(:quentin), Controller.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    controllers(:quentin).update_attribute(:login, 'quentin2')
    assert_equal controllers(:quentin), Controller.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_controller
    assert_equal controllers(:quentin), Controller.authenticate('quentin', 'quentin')
  end

  protected
  def create_controller(options = {})
    Controller.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
