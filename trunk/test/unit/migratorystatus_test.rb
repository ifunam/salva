require File.dirname(__FILE__) + '/../test_helper'

class MigratorystatusTest < Test::Unit::TestCase
  fixtures :migratorystatuses

  def test_should_create_migratorystatus
    assert create_migratorystatus.valid?
  end

  def test_should_require_login
    u = create_migratorystatus(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_migratorystatus(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_migratorystatus(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_migratorystatus(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    migratorystatuses(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal migratorystatuses(:quentin), Migratorystatus.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    migratorystatuses(:quentin).update_attribute(:login, 'quentin2')
    assert_equal migratorystatuses(:quentin), Migratorystatus.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_migratorystatus
    assert_equal migratorystatuses(:quentin), Migratorystatus.authenticate('quentin', 'quentin')
  end

  protected
  def create_migratorystatus(options = {})
    Migratorystatus.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
