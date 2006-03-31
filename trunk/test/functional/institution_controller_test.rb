require File.dirname(__FILE__) + '/../test_helper'
require 'institution_controller'

# Re-raise errors caught by the controller.
class InstitutionController; def rescue_action(e) raise e end; end

class InstitutionControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :institutions

  def setup
    @controller = InstitutionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:institution]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:institution]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Institution.count
    create_institution
    assert_response :redirect
    assert_equal old_count+1, Institution.count
  end

  def test_should_require_login_on_signup
    old_count = Institution.count
    create_institution(:login => nil)
    assert assigns(:institution).errors.on(:login)
    assert_response :success
    assert_equal old_count, Institution.count
  end

  def test_should_require_password_on_signup
    old_count = Institution.count
    create_institution(:password => nil)
    assert assigns(:institution).errors.on(:password)
    assert_response :success
    assert_equal old_count, Institution.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Institution.count
    create_institution(:password_confirmation => nil)
    assert assigns(:institution).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Institution.count
  end

  def test_should_require_email_on_signup
    old_count = Institution.count
    create_institution(:email => nil)
    assert assigns(:institution).errors.on(:email)
    assert_response :success
    assert_equal old_count, Institution.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:institution]
    assert_response :redirect
  end
  
  protected
  def create_institution(options = {})
    post :signup, :institution => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
