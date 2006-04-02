require File.dirname(__FILE__) + '/../test_helper'

class DegreeTest < Test::Unit::TestCase
  fixtures :degrees

  def test_should_create_degree
    assert create_degree.valid?
  end

  def test_should_require_login
    u = create_degree(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_degree(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_degree(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_degree(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    degrees(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal degrees(:quentin), Degree.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    degrees(:quentin).update_attribute(:login, 'quentin2')
    assert_equal degrees(:quentin), Degree.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_degree
    assert_equal degrees(:quentin), Degree.authenticate('quentin', 'quentin')
  end

  protected
  def create_degree(options = {})
    Degree.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
