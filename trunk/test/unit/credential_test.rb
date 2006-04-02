require File.dirname(__FILE__) + '/../test_helper'

class CredentialTest < Test::Unit::TestCase
  fixtures :credentials

  def test_should_create_credential
    assert create_credential.valid?
  end

  def test_should_require_login
    u = create_credential(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_credential(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_credential(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_credential(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    credentials(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal credentials(:quentin), Credential.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    credentials(:quentin).update_attribute(:login, 'quentin2')
    assert_equal credentials(:quentin), Credential.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_credential
    assert_equal credentials(:quentin), Credential.authenticate('quentin', 'quentin')
  end

  protected
  def create_credential(options = {})
    Credential.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
