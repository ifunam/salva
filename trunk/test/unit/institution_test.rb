require File.dirname(__FILE__) + '/../test_helper'

class InstitutionTest < Test::Unit::TestCase
  fixtures :institutions

  def test_should_create_institution
    assert create_institution.valid?
  end

  def test_should_require_login
    u = create_institution(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_institution(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_institution(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_institution(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    institutions(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal institutions(:quentin), Institution.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    institutions(:quentin).update_attribute(:login, 'quentin2')
    assert_equal institutions(:quentin), Institution.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_institution
    assert_equal institutions(:quentin), Institution.authenticate('quentin', 'quentin')
  end

  protected
  def create_institution(options = {})
    Institution.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
