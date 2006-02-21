require File.dirname(__FILE__) + '/../test_helper'

class StateTest < Test::Unit::TestCase
  fixtures :states

  def test_should_create_state
    assert create_state.valid?
  end

  def test_should_require_login
    u = create_state(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_state(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_state(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_state(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    states(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal states(:quentin), State.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    states(:quentin).update_attribute(:login, 'quentin2')
    assert_equal states(:quentin), State.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_state
    assert_equal states(:quentin), State.authenticate('quentin', 'quentin')
  end

  protected
  def create_state(options = {})
    State.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
