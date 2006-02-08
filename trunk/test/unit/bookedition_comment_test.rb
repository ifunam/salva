require File.dirname(__FILE__) + '/../test_helper'

class BookeditionCommentTest < Test::Unit::TestCase
  fixtures :bookedition_comments

  def test_should_create_bookedition_comment
    assert create_bookedition_comment.valid?
  end

  def test_should_require_login
    u = create_bookedition_comment(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_bookedition_comment(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_bookedition_comment(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_bookedition_comment(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    bookedition_comments(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal bookedition_comments(:quentin), BookeditionComment.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    bookedition_comments(:quentin).update_attribute(:login, 'quentin2')
    assert_equal bookedition_comments(:quentin), BookeditionComment.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_bookedition_comment
    assert_equal bookedition_comments(:quentin), BookeditionComment.authenticate('quentin', 'quentin')
  end

  protected
  def create_bookedition_comment(options = {})
    BookeditionComment.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
