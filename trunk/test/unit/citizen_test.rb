require File.dirname(__FILE__) + '/../test_helper'

class CitizenTest < Test::Unit::TestCase
  fixtures :citizens

  def test_should_create_citizen
    assert create_citizen.valid?
  end

  def test_should_require_login
    u = create_citizen(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_citizen(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_citizen(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_citizen(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    citizens(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal citizens(:quentin), Citizen.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    citizens(:quentin).update_attribute(:login, 'quentin2')
    assert_equal citizens(:quentin), Citizen.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_citizen
    assert_equal citizens(:quentin), Citizen.authenticate('quentin', 'quentin')
  end

  protected
  def create_citizen(options = {})
    Citizen.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
