require File.dirname(__FILE__) + '/../test_helper'

class ChapterinbookRoleinbookTest < Test::Unit::TestCase
  fixtures :chapterinbook_roleinbooks

  def test_should_create_chapterinbook_roleinbook
    assert create_chapterinbook_roleinbook.valid?
  end

  def test_should_require_login
    u = create_chapterinbook_roleinbook(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_chapterinbook_roleinbook(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_chapterinbook_roleinbook(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_chapterinbook_roleinbook(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    chapterinbook_roleinbooks(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal chapterinbook_roleinbooks(:quentin), ChapterinbookRoleinbook.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    chapterinbook_roleinbooks(:quentin).update_attribute(:login, 'quentin2')
    assert_equal chapterinbook_roleinbooks(:quentin), ChapterinbookRoleinbook.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_chapterinbook_roleinbook
    assert_equal chapterinbook_roleinbooks(:quentin), ChapterinbookRoleinbook.authenticate('quentin', 'quentin')
  end

  protected
  def create_chapterinbook_roleinbook(options = {})
    ChapterinbookRoleinbook.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
