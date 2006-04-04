require File.dirname(__FILE__) + '/../test_helper'
require 'jobpositionlevel_controller'

# Re-raise errors caught by the controller.
class JobpositionlevelController; def rescue_action(e) raise e end; end

class JobpositionlevelControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :jobpositionlevels

  def setup
    @controller = JobpositionlevelController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:jobpositionlevel]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:jobpositionlevel]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Jobpositionlevel.count
    create_jobpositionlevel
    assert_response :redirect
    assert_equal old_count+1, Jobpositionlevel.count
  end

  def test_should_require_login_on_signup
    old_count = Jobpositionlevel.count
    create_jobpositionlevel(:login => nil)
    assert assigns(:jobpositionlevel).errors.on(:login)
    assert_response :success
    assert_equal old_count, Jobpositionlevel.count
  end

  def test_should_require_password_on_signup
    old_count = Jobpositionlevel.count
    create_jobpositionlevel(:password => nil)
    assert assigns(:jobpositionlevel).errors.on(:password)
    assert_response :success
    assert_equal old_count, Jobpositionlevel.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Jobpositionlevel.count
    create_jobpositionlevel(:password_confirmation => nil)
    assert assigns(:jobpositionlevel).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Jobpositionlevel.count
  end

  def test_should_require_email_on_signup
    old_count = Jobpositionlevel.count
    create_jobpositionlevel(:email => nil)
    assert assigns(:jobpositionlevel).errors.on(:email)
    assert_response :success
    assert_equal old_count, Jobpositionlevel.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:jobpositionlevel]
    assert_response :redirect
  end
  
  protected
  def create_jobpositionlevel(options = {})
    post :signup, :jobpositionlevel => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
