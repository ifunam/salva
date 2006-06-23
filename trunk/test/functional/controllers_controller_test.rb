require File.dirname(__FILE__) + '/../test_helper'
require 'controllers_controller'

# Re-raise errors caught by the controller.
class ControllersController; def rescue_action(e) raise e end; end

class ControllersControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :controllers

  def setup
    @controller = ControllersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:controller]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:controller]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Controller.count
    create_controller
    assert_response :redirect
    assert_equal old_count+1, Controller.count
  end

  def test_should_require_login_on_signup
    old_count = Controller.count
    create_controller(:login => nil)
    assert assigns(:controller).errors.on(:login)
    assert_response :success
    assert_equal old_count, Controller.count
  end

  def test_should_require_password_on_signup
    old_count = Controller.count
    create_controller(:password => nil)
    assert assigns(:controller).errors.on(:password)
    assert_response :success
    assert_equal old_count, Controller.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Controller.count
    create_controller(:password_confirmation => nil)
    assert assigns(:controller).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Controller.count
  end

  def test_should_require_email_on_signup
    old_count = Controller.count
    create_controller(:email => nil)
    assert assigns(:controller).errors.on(:email)
    assert_response :success
    assert_equal old_count, Controller.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:controller]
    assert_response :redirect
  end
  
  protected
  def create_controller(options = {})
    post :signup, :controller => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
