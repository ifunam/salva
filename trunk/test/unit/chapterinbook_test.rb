require File.dirname(__FILE__) + '/../test_helper'

class ChapterinbookTest < Test::Unit::TestCase
  fixtures :chapterinbooks

  def test_should_create_chapterinbook
    assert create_chapterinbook.valid?
  end

  def test_should_require_login
    u = create_chapterinbook(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_chapterinbook(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_chapterinbook(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_chapterinbook(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    chapterinbooks(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal chapterinbooks(:quentin), Chapterinbook.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    chapterinbooks(:quentin).update_attribute(:login, 'quentin2')
    assert_equal chapterinbooks(:quentin), Chapterinbook.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_chapterinbook
    assert_equal chapterinbooks(:quentin), Chapterinbook.authenticate('quentin', 'quentin')
  end

  protected
  def create_chapterinbook(options = {})
    Chapterinbook.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
