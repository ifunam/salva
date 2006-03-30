require File.dirname(__FILE__) + '/../test_helper'

class IdcitizenTest < Test::Unit::TestCase
  fixtures :idcitizens

  def test_should_create_idcitizen
    assert create_idcitizen.valid?
  end

  def test_should_require_login
    u = create_idcitizen(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_idcitizen(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_idcitizen(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_idcitizen(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    idcitizens(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal idcitizens(:quentin), Idcitizen.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    idcitizens(:quentin).update_attribute(:login, 'quentin2')
    assert_equal idcitizens(:quentin), Idcitizen.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_idcitizen
    assert_equal idcitizens(:quentin), Idcitizen.authenticate('quentin', 'quentin')
  end

  protected
  def create_idcitizen(options = {})
    Idcitizen.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
