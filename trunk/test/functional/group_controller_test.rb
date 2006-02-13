require File.dirname(__FILE__) + '/../test_helper'
require 'group_controller'

# Re-raise errors caught by the controller.
class GroupController; def rescue_action(e) raise e end; end

class GroupControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :groups

  def setup
    @controller = GroupController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:group]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:group]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Group.count
    create_group
    assert_response :redirect
    assert_equal old_count+1, Group.count
  end

  def test_should_require_login_on_signup
    old_count = Group.count
    create_group(:login => nil)
    assert assigns(:group).errors.on(:login)
    assert_response :success
    assert_equal old_count, Group.count
  end

  def test_should_require_password_on_signup
    old_count = Group.count
    create_group(:password => nil)
    assert assigns(:group).errors.on(:password)
    assert_response :success
    assert_equal old_count, Group.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Group.count
    create_group(:password_confirmation => nil)
    assert assigns(:group).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Group.count
  end

  def test_should_require_email_on_signup
    old_count = Group.count
    create_group(:email => nil)
    assert assigns(:group).errors.on(:email)
    assert_response :success
    assert_equal old_count, Group.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:group]
    assert_response :redirect
  end
  
  protected
  def create_group(options = {})
    post :signup, :group => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
