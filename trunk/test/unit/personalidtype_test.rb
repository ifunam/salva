require File.dirname(__FILE__) + '/../test_helper'

class PersonalidtypeTest < Test::Unit::TestCase
  fixtures :personalidtypes

  def test_should_create_personalidtype
    assert create_personalidtype.valid?
  end

  def test_should_require_login
    u = create_personalidtype(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_personalidtype(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_personalidtype(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_personalidtype(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    personalidtypes(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal personalidtypes(:quentin), Personalidtype.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    personalidtypes(:quentin).update_attribute(:login, 'quentin2')
    assert_equal personalidtypes(:quentin), Personalidtype.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_personalidtype
    assert_equal personalidtypes(:quentin), Personalidtype.authenticate('quentin', 'quentin')
  end

  protected
  def create_personalidtype(options = {})
    Personalidtype.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
