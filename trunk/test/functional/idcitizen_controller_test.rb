require File.dirname(__FILE__) + '/../test_helper'
require 'idcitizen_controller'

# Re-raise errors caught by the controller.
class IdcitizenController; def rescue_action(e) raise e end; end

class IdcitizenControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :idcitizens

  def setup
    @controller = IdcitizenController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:idcitizen]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:idcitizen]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Idcitizen.count
    create_idcitizen
    assert_response :redirect
    assert_equal old_count+1, Idcitizen.count
  end

  def test_should_require_login_on_signup
    old_count = Idcitizen.count
    create_idcitizen(:login => nil)
    assert assigns(:idcitizen).errors.on(:login)
    assert_response :success
    assert_equal old_count, Idcitizen.count
  end

  def test_should_require_password_on_signup
    old_count = Idcitizen.count
    create_idcitizen(:password => nil)
    assert assigns(:idcitizen).errors.on(:password)
    assert_response :success
    assert_equal old_count, Idcitizen.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Idcitizen.count
    create_idcitizen(:password_confirmation => nil)
    assert assigns(:idcitizen).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Idcitizen.count
  end

  def test_should_require_email_on_signup
    old_count = Idcitizen.count
    create_idcitizen(:email => nil)
    assert assigns(:idcitizen).errors.on(:email)
    assert_response :success
    assert_equal old_count, Idcitizen.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:idcitizen]
    assert_response :redirect
  end
  
  protected
  def create_idcitizen(options = {})
    post :signup, :idcitizen => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
