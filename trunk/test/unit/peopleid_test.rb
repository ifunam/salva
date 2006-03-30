require File.dirname(__FILE__) + '/../test_helper'

class PeopleidTest < Test::Unit::TestCase
  fixtures :peopleids

  def test_should_create_peopleid
    assert create_peopleid.valid?
  end

  def test_should_require_login
    u = create_peopleid(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_peopleid(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_peopleid(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_peopleid(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    peopleids(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal peopleids(:quentin), Peopleid.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    peopleids(:quentin).update_attribute(:login, 'quentin2')
    assert_equal peopleids(:quentin), Peopleid.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_peopleid
    assert_equal peopleids(:quentin), Peopleid.authenticate('quentin', 'quentin')
  end

  protected
  def create_peopleid(options = {})
    Peopleid.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
