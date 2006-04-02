require File.dirname(__FILE__) + '/../test_helper'
require 'schooling_controller'

# Re-raise errors caught by the controller.
class SchoolingController; def rescue_action(e) raise e end; end

class SchoolingControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :schoolings

  def setup
    @controller = SchoolingController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:schooling]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:schooling]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Schooling.count
    create_schooling
    assert_response :redirect
    assert_equal old_count+1, Schooling.count
  end

  def test_should_require_login_on_signup
    old_count = Schooling.count
    create_schooling(:login => nil)
    assert assigns(:schooling).errors.on(:login)
    assert_response :success
    assert_equal old_count, Schooling.count
  end

  def test_should_require_password_on_signup
    old_count = Schooling.count
    create_schooling(:password => nil)
    assert assigns(:schooling).errors.on(:password)
    assert_response :success
    assert_equal old_count, Schooling.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Schooling.count
    create_schooling(:password_confirmation => nil)
    assert assigns(:schooling).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Schooling.count
  end

  def test_should_require_email_on_signup
    old_count = Schooling.count
    create_schooling(:email => nil)
    assert assigns(:schooling).errors.on(:email)
    assert_response :success
    assert_equal old_count, Schooling.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:schooling]
    assert_response :redirect
  end
  
  protected
  def create_schooling(options = {})
    post :signup, :schooling => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
