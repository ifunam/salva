require File.dirname(__FILE__) + '/../test_helper'

class SchoolingTest < Test::Unit::TestCase
  fixtures :schoolings

  def test_should_create_schooling
    assert create_schooling.valid?
  end

  def test_should_require_login
    u = create_schooling(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_schooling(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_schooling(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_schooling(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    schoolings(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal schoolings(:quentin), Schooling.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    schoolings(:quentin).update_attribute(:login, 'quentin2')
    assert_equal schoolings(:quentin), Schooling.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_schooling
    assert_equal schoolings(:quentin), Schooling.authenticate('quentin', 'quentin')
  end

  protected
  def create_schooling(options = {})
    Schooling.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
