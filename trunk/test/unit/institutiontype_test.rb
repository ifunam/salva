require File.dirname(__FILE__) + '/../test_helper'

class InstitutiontypeTest < Test::Unit::TestCase
  fixtures :institutiontypes

  def test_should_create_institutiontype
    assert create_institutiontype.valid?
  end

  def test_should_require_login
    u = create_institutiontype(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_institutiontype(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_institutiontype(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_institutiontype(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    institutiontypes(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal institutiontypes(:quentin), Institutiontype.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    institutiontypes(:quentin).update_attribute(:login, 'quentin2')
    assert_equal institutiontypes(:quentin), Institutiontype.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_institutiontype
    assert_equal institutiontypes(:quentin), Institutiontype.authenticate('quentin', 'quentin')
  end

  protected
  def create_institutiontype(options = {})
    Institutiontype.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
