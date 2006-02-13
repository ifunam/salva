require File.dirname(__FILE__) + '/../test_helper'

class GroupTest < Test::Unit::TestCase
  fixtures :groups

  def test_should_create_group
    assert create_group.valid?
  end

  def test_should_require_login
    u = create_group(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_group(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_group(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_group(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    groups(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal groups(:quentin), Group.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    groups(:quentin).update_attribute(:login, 'quentin2')
    assert_equal groups(:quentin), Group.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_group
    assert_equal groups(:quentin), Group.authenticate('quentin', 'quentin')
  end

  protected
  def create_group(options = {})
    Group.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
