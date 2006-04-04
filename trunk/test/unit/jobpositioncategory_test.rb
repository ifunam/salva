require File.dirname(__FILE__) + '/../test_helper'

class JobpositioncategoryTest < Test::Unit::TestCase
  fixtures :jobpositioncategories

  def test_should_create_jobpositioncategory
    assert create_jobpositioncategory.valid?
  end

  def test_should_require_login
    u = create_jobpositioncategory(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_jobpositioncategory(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_jobpositioncategory(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_jobpositioncategory(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    jobpositioncategories(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal jobpositioncategories(:quentin), Jobpositioncategory.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    jobpositioncategories(:quentin).update_attribute(:login, 'quentin2')
    assert_equal jobpositioncategories(:quentin), Jobpositioncategory.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_jobpositioncategory
    assert_equal jobpositioncategories(:quentin), Jobpositioncategory.authenticate('quentin', 'quentin')
  end

  protected
  def create_jobpositioncategory(options = {})
    Jobpositioncategory.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
