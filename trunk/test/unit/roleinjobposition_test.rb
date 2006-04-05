require File.dirname(__FILE__) + '/../test_helper'

class RoleinjobpositionTest < Test::Unit::TestCase
  fixtures :roleinjobpositions

  def test_should_create_roleinjobposition
    assert create_roleinjobposition.valid?
  end

  def test_should_require_login
    u = create_roleinjobposition(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_roleinjobposition(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_roleinjobposition(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_roleinjobposition(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    roleinjobpositions(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal roleinjobpositions(:quentin), Roleinjobposition.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    roleinjobpositions(:quentin).update_attribute(:login, 'quentin2')
    assert_equal roleinjobpositions(:quentin), Roleinjobposition.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_roleinjobposition
    assert_equal roleinjobpositions(:quentin), Roleinjobposition.authenticate('quentin', 'quentin')
  end

  protected
  def create_roleinjobposition(options = {})
    Roleinjobposition.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
