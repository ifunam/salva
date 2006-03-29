require File.dirname(__FILE__) + '/../test_helper'
require 'citizen_controller'

# Re-raise errors caught by the controller.
class CitizenController; def rescue_action(e) raise e end; end

class CitizenControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :citizens

  def setup
    @controller = CitizenController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:citizen]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:citizen]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Citizen.count
    create_citizen
    assert_response :redirect
    assert_equal old_count+1, Citizen.count
  end

  def test_should_require_login_on_signup
    old_count = Citizen.count
    create_citizen(:login => nil)
    assert assigns(:citizen).errors.on(:login)
    assert_response :success
    assert_equal old_count, Citizen.count
  end

  def test_should_require_password_on_signup
    old_count = Citizen.count
    create_citizen(:password => nil)
    assert assigns(:citizen).errors.on(:password)
    assert_response :success
    assert_equal old_count, Citizen.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Citizen.count
    create_citizen(:password_confirmation => nil)
    assert assigns(:citizen).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Citizen.count
  end

  def test_should_require_email_on_signup
    old_count = Citizen.count
    create_citizen(:email => nil)
    assert assigns(:citizen).errors.on(:email)
    assert_response :success
    assert_equal old_count, Citizen.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:citizen]
    assert_response :redirect
  end
  
  protected
  def create_citizen(options = {})
    post :signup, :citizen => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
