require File.dirname(__FILE__) + '/../test_helper'

class ContracttypeTest < Test::Unit::TestCase
  fixtures :contracttypes

  def test_should_create_contracttype
    assert create_contracttype.valid?
  end

  def test_should_require_login
    u = create_contracttype(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_contracttype(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_contracttype(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_contracttype(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    contracttypes(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal contracttypes(:quentin), Contracttype.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    contracttypes(:quentin).update_attribute(:login, 'quentin2')
    assert_equal contracttypes(:quentin), Contracttype.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_contracttype
    assert_equal contracttypes(:quentin), Contracttype.authenticate('quentin', 'quentin')
  end

  protected
  def create_contracttype(options = {})
    Contracttype.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
