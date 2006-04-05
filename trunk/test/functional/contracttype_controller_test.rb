require File.dirname(__FILE__) + '/../test_helper'
require 'contracttype_controller'

# Re-raise errors caught by the controller.
class ContracttypeController; def rescue_action(e) raise e end; end

class ContracttypeControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :contracttypes

  def setup
    @controller = ContracttypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:contracttype]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:contracttype]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Contracttype.count
    create_contracttype
    assert_response :redirect
    assert_equal old_count+1, Contracttype.count
  end

  def test_should_require_login_on_signup
    old_count = Contracttype.count
    create_contracttype(:login => nil)
    assert assigns(:contracttype).errors.on(:login)
    assert_response :success
    assert_equal old_count, Contracttype.count
  end

  def test_should_require_password_on_signup
    old_count = Contracttype.count
    create_contracttype(:password => nil)
    assert assigns(:contracttype).errors.on(:password)
    assert_response :success
    assert_equal old_count, Contracttype.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Contracttype.count
    create_contracttype(:password_confirmation => nil)
    assert assigns(:contracttype).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Contracttype.count
  end

  def test_should_require_email_on_signup
    old_count = Contracttype.count
    create_contracttype(:email => nil)
    assert assigns(:contracttype).errors.on(:email)
    assert_response :success
    assert_equal old_count, Contracttype.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:contracttype]
    assert_response :redirect
  end
  
  protected
  def create_contracttype(options = {})
    post :signup, :contracttype => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
