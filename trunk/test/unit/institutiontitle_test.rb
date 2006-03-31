require File.dirname(__FILE__) + '/../test_helper'

class InstitutiontitleTest < Test::Unit::TestCase
  fixtures :institutiontitles

  def test_should_create_institutiontitle
    assert create_institutiontitle.valid?
  end

  def test_should_require_login
    u = create_institutiontitle(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_institutiontitle(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_institutiontitle(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_institutiontitle(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    institutiontitles(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal institutiontitles(:quentin), Institutiontitle.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    institutiontitles(:quentin).update_attribute(:login, 'quentin2')
    assert_equal institutiontitles(:quentin), Institutiontitle.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_institutiontitle
    assert_equal institutiontitles(:quentin), Institutiontitle.authenticate('quentin', 'quentin')
  end

  protected
  def create_institutiontitle(options = {})
    Institutiontitle.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
