require File.dirname(__FILE__) + '/../test_helper'

class CityTest < Test::Unit::TestCase
  fixtures :cities

  def test_should_create_city
    assert create_city.valid?
  end

  def test_should_require_login
    u = create_city(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_city(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_city(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_city(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    cities(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal cities(:quentin), City.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    cities(:quentin).update_attribute(:login, 'quentin2')
    assert_equal cities(:quentin), City.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_city
    assert_equal cities(:quentin), City.authenticate('quentin', 'quentin')
  end

  protected
  def create_city(options = {})
    City.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
