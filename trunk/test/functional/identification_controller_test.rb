require File.dirname(__FILE__) + '/../test_helper'
require 'identification_controller'

# Re-raise errors caught by the controller.
class IdentificationController; def rescue_action(e) raise e end; end

class IdentificationControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :identifications

  def setup
    @controller = IdentificationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:identification]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:identification]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Identification.count
    create_identification
    assert_response :redirect
    assert_equal old_count+1, Identification.count
  end

  def test_should_require_login_on_signup
    old_count = Identification.count
    create_identification(:login => nil)
    assert assigns(:identification).errors.on(:login)
    assert_response :success
    assert_equal old_count, Identification.count
  end

  def test_should_require_password_on_signup
    old_count = Identification.count
    create_identification(:password => nil)
    assert assigns(:identification).errors.on(:password)
    assert_response :success
    assert_equal old_count, Identification.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Identification.count
    create_identification(:password_confirmation => nil)
    assert assigns(:identification).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Identification.count
  end

  def test_should_require_email_on_signup
    old_count = Identification.count
    create_identification(:email => nil)
    assert assigns(:identification).errors.on(:email)
    assert_response :success
    assert_equal old_count, Identification.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:identification]
    assert_response :redirect
  end
  
  protected
  def create_identification(options = {})
    post :signup, :identification => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
