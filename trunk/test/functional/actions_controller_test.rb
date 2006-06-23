require File.dirname(__FILE__) + '/../test_helper'
require 'actions_controller'

# Re-raise errors caught by the controller.
class ActionsController; def rescue_action(e) raise e end; end

class ActionsControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :actions

  def setup
    @controller = ActionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:action]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:action]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Action.count
    create_action
    assert_response :redirect
    assert_equal old_count+1, Action.count
  end

  def test_should_require_login_on_signup
    old_count = Action.count
    create_action(:login => nil)
    assert assigns(:action).errors.on(:login)
    assert_response :success
    assert_equal old_count, Action.count
  end

  def test_should_require_password_on_signup
    old_count = Action.count
    create_action(:password => nil)
    assert assigns(:action).errors.on(:password)
    assert_response :success
    assert_equal old_count, Action.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Action.count
    create_action(:password_confirmation => nil)
    assert assigns(:action).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Action.count
  end

  def test_should_require_email_on_signup
    old_count = Action.count
    create_action(:email => nil)
    assert assigns(:action).errors.on(:email)
    assert_response :success
    assert_equal old_count, Action.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:action]
    assert_response :redirect
  end
  
  protected
  def create_action(options = {})
    post :signup, :action => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
