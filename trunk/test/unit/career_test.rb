require File.dirname(__FILE__) + '/../test_helper'

class CareerTest < Test::Unit::TestCase
  fixtures :careers

  def test_should_create_career
    assert create_career.valid?
  end

  def test_should_require_login
    u = create_career(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_career(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_career(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_career(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    careers(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal careers(:quentin), Career.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    careers(:quentin).update_attribute(:login, 'quentin2')
    assert_equal careers(:quentin), Career.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_career
    assert_equal careers(:quentin), Career.authenticate('quentin', 'quentin')
  end

  protected
  def create_career(options = {})
    Career.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
