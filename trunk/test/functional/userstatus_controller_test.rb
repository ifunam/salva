require File.dirname(__FILE__) + '/../test_helper'
require 'userstatus_controller'

# Re-raise errors caught by the controller.
class UserstatusController; def rescue_action(e) raise e end; end

class UserstatusControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :userstatuses

  def setup
    @controller = UserstatusController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:userstatus]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:userstatus]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Userstatus.count
    create_userstatus
    assert_response :redirect
    assert_equal old_count+1, Userstatus.count
  end

  def test_should_require_login_on_signup
    old_count = Userstatus.count
    create_userstatus(:login => nil)
    assert assigns(:userstatus).errors.on(:login)
    assert_response :success
    assert_equal old_count, Userstatus.count
  end

  def test_should_require_password_on_signup
    old_count = Userstatus.count
    create_userstatus(:password => nil)
    assert assigns(:userstatus).errors.on(:password)
    assert_response :success
    assert_equal old_count, Userstatus.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Userstatus.count
    create_userstatus(:password_confirmation => nil)
    assert assigns(:userstatus).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Userstatus.count
  end

  def test_should_require_email_on_signup
    old_count = Userstatus.count
    create_userstatus(:email => nil)
    assert assigns(:userstatus).errors.on(:email)
    assert_response :success
    assert_equal old_count, Userstatus.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:userstatus]
    assert_response :redirect
  end
  
  protected
  def create_userstatus(options = {})
    post :signup, :userstatus => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
