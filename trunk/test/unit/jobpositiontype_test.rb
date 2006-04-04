require File.dirname(__FILE__) + '/../test_helper'

class JobpositiontypeTest < Test::Unit::TestCase
  fixtures :jobpositiontypes

  def test_should_create_jobpositiontype
    assert create_jobpositiontype.valid?
  end

  def test_should_require_login
    u = create_jobpositiontype(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_jobpositiontype(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_jobpositiontype(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_jobpositiontype(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    jobpositiontypes(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal jobpositiontypes(:quentin), Jobpositiontype.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    jobpositiontypes(:quentin).update_attribute(:login, 'quentin2')
    assert_equal jobpositiontypes(:quentin), Jobpositiontype.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_jobpositiontype
    assert_equal jobpositiontypes(:quentin), Jobpositiontype.authenticate('quentin', 'quentin')
  end

  protected
  def create_jobpositiontype(options = {})
    Jobpositiontype.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
