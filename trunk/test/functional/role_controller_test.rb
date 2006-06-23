require File.dirname(__FILE__) + '/../test_helper'
require 'role_controller'

# Re-raise errors caught by the controller.
class RoleController; def rescue_action(e) raise e end; end

class RoleControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :roles

  def setup
    @controller = RoleController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:role]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:role]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Role.count
    create_role
    assert_response :redirect
    assert_equal old_count+1, Role.count
  end

  def test_should_require_login_on_signup
    old_count = Role.count
    create_role(:login => nil)
    assert assigns(:role).errors.on(:login)
    assert_response :success
    assert_equal old_count, Role.count
  end

  def test_should_require_password_on_signup
    old_count = Role.count
    create_role(:password => nil)
    assert assigns(:role).errors.on(:password)
    assert_response :success
    assert_equal old_count, Role.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Role.count
    create_role(:password_confirmation => nil)
    assert assigns(:role).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Role.count
  end

  def test_should_require_email_on_signup
    old_count = Role.count
    create_role(:email => nil)
    assert assigns(:role).errors.on(:email)
    assert_response :success
    assert_equal old_count, Role.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:role]
    assert_response :redirect
  end
  
  protected
  def create_role(options = {})
    post :signup, :role => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
