require File.dirname(__FILE__) + '/../test_helper'

class JobpositionlevelTest < Test::Unit::TestCase
  fixtures :jobpositionlevels

  def test_should_create_jobpositionlevel
    assert create_jobpositionlevel.valid?
  end

  def test_should_require_login
    u = create_jobpositionlevel(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_jobpositionlevel(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_jobpositionlevel(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_jobpositionlevel(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    jobpositionlevels(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal jobpositionlevels(:quentin), Jobpositionlevel.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    jobpositionlevels(:quentin).update_attribute(:login, 'quentin2')
    assert_equal jobpositionlevels(:quentin), Jobpositionlevel.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_jobpositionlevel
    assert_equal jobpositionlevels(:quentin), Jobpositionlevel.authenticate('quentin', 'quentin')
  end

  protected
  def create_jobpositionlevel(options = {})
    Jobpositionlevel.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
