require File.dirname(__FILE__) + '/../test_helper'
require 'institutiontitle_controller'

# Re-raise errors caught by the controller.
class InstitutiontitleController; def rescue_action(e) raise e end; end

class InstitutiontitleControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :institutiontitles

  def setup
    @controller = InstitutiontitleController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:institutiontitle]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:institutiontitle]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Institutiontitle.count
    create_institutiontitle
    assert_response :redirect
    assert_equal old_count+1, Institutiontitle.count
  end

  def test_should_require_login_on_signup
    old_count = Institutiontitle.count
    create_institutiontitle(:login => nil)
    assert assigns(:institutiontitle).errors.on(:login)
    assert_response :success
    assert_equal old_count, Institutiontitle.count
  end

  def test_should_require_password_on_signup
    old_count = Institutiontitle.count
    create_institutiontitle(:password => nil)
    assert assigns(:institutiontitle).errors.on(:password)
    assert_response :success
    assert_equal old_count, Institutiontitle.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Institutiontitle.count
    create_institutiontitle(:password_confirmation => nil)
    assert assigns(:institutiontitle).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Institutiontitle.count
  end

  def test_should_require_email_on_signup
    old_count = Institutiontitle.count
    create_institutiontitle(:email => nil)
    assert assigns(:institutiontitle).errors.on(:email)
    assert_response :success
    assert_equal old_count, Institutiontitle.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:institutiontitle]
    assert_response :redirect
  end
  
  protected
  def create_institutiontitle(options = {})
    post :signup, :institutiontitle => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
