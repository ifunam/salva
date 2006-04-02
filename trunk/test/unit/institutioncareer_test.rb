require File.dirname(__FILE__) + '/../test_helper'

class InstitutioncareerTest < Test::Unit::TestCase
  fixtures :institutioncareers

  def test_should_create_institutioncareer
    assert create_institutioncareer.valid?
  end

  def test_should_require_login
    u = create_institutioncareer(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_institutioncareer(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_institutioncareer(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_institutioncareer(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    institutioncareers(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal institutioncareers(:quentin), Institutioncareer.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    institutioncareers(:quentin).update_attribute(:login, 'quentin2')
    assert_equal institutioncareers(:quentin), Institutioncareer.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_institutioncareer
    assert_equal institutioncareers(:quentin), Institutioncareer.authenticate('quentin', 'quentin')
  end

  protected
  def create_institutioncareer(options = {})
    Institutioncareer.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
