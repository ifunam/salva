require File.dirname(__FILE__) + '/../test_helper'

class ChapterinbookCommentTest < Test::Unit::TestCase
  fixtures :chapterinbook_comments

  def test_should_create_chapterinbook_comment
    assert create_chapterinbook_comment.valid?
  end

  def test_should_require_login
    u = create_chapterinbook_comment(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_chapterinbook_comment(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_chapterinbook_comment(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_chapterinbook_comment(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    chapterinbook_comments(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal chapterinbook_comments(:quentin), ChapterinbookComment.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    chapterinbook_comments(:quentin).update_attribute(:login, 'quentin2')
    assert_equal chapterinbook_comments(:quentin), ChapterinbookComment.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_chapterinbook_comment
    assert_equal chapterinbook_comments(:quentin), ChapterinbookComment.authenticate('quentin', 'quentin')
  end

  protected
  def create_chapterinbook_comment(options = {})
    ChapterinbookComment.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
