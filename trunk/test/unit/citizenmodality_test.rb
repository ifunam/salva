require File.dirname(__FILE__) + '/../test_helper'

class CitizenmodalityTest < Test::Unit::TestCase
  fixtures :citizenmodalities

  def test_should_create_citizenmodality
    assert create_citizenmodality.valid?
  end

  def test_should_require_login
    u = create_citizenmodality(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_citizenmodality(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_citizenmodality(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_citizenmodality(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    citizenmodalities(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal citizenmodalities(:quentin), Citizenmodality.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    citizenmodalities(:quentin).update_attribute(:login, 'quentin2')
    assert_equal citizenmodalities(:quentin), Citizenmodality.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_citizenmodality
    assert_equal citizenmodalities(:quentin), Citizenmodality.authenticate('quentin', 'quentin')
  end

  protected
  def create_citizenmodality(options = {})
    Citizenmodality.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
