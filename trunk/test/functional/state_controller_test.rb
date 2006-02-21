require File.dirname(__FILE__) + '/../test_helper'
require 'state_controller'

# Re-raise errors caught by the controller.
class StateController; def rescue_action(e) raise e end; end

class StateControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :states

  def setup
    @controller = StateController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:state]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:state]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = State.count
    create_state
    assert_response :redirect
    assert_equal old_count+1, State.count
  end

  def test_should_require_login_on_signup
    old_count = State.count
    create_state(:login => nil)
    assert assigns(:state).errors.on(:login)
    assert_response :success
    assert_equal old_count, State.count
  end

  def test_should_require_password_on_signup
    old_count = State.count
    create_state(:password => nil)
    assert assigns(:state).errors.on(:password)
    assert_response :success
    assert_equal old_count, State.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = State.count
    create_state(:password_confirmation => nil)
    assert assigns(:state).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, State.count
  end

  def test_should_require_email_on_signup
    old_count = State.count
    create_state(:email => nil)
    assert assigns(:state).errors.on(:email)
    assert_response :success
    assert_equal old_count, State.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:state]
    assert_response :redirect
  end
  
  protected
  def create_state(options = {})
    post :signup, :state => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
