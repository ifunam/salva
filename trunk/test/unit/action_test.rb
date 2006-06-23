require File.dirname(__FILE__) + '/../test_helper'

class ActionTest < Test::Unit::TestCase
  fixtures :actions

  def test_should_create_action
    assert create_action.valid?
  end

  def test_should_require_login
    u = create_action(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_action(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_action(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_action(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    actions(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal actions(:quentin), Action.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    actions(:quentin).update_attribute(:login, 'quentin2')
    assert_equal actions(:quentin), Action.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_action
    assert_equal actions(:quentin), Action.authenticate('quentin', 'quentin')
  end

  protected
  def create_action(options = {})
    Action.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
