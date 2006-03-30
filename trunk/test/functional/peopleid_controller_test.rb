require File.dirname(__FILE__) + '/../test_helper'
require 'peopleid_controller'

# Re-raise errors caught by the controller.
class PeopleidController; def rescue_action(e) raise e end; end

class PeopleidControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :peopleids

  def setup
    @controller = PeopleidController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:peopleid]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:peopleid]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Peopleid.count
    create_peopleid
    assert_response :redirect
    assert_equal old_count+1, Peopleid.count
  end

  def test_should_require_login_on_signup
    old_count = Peopleid.count
    create_peopleid(:login => nil)
    assert assigns(:peopleid).errors.on(:login)
    assert_response :success
    assert_equal old_count, Peopleid.count
  end

  def test_should_require_password_on_signup
    old_count = Peopleid.count
    create_peopleid(:password => nil)
    assert assigns(:peopleid).errors.on(:password)
    assert_response :success
    assert_equal old_count, Peopleid.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Peopleid.count
    create_peopleid(:password_confirmation => nil)
    assert assigns(:peopleid).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Peopleid.count
  end

  def test_should_require_email_on_signup
    old_count = Peopleid.count
    create_peopleid(:email => nil)
    assert assigns(:peopleid).errors.on(:email)
    assert_response :success
    assert_equal old_count, Peopleid.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:peopleid]
    assert_response :redirect
  end
  
  protected
  def create_peopleid(options = {})
    post :signup, :peopleid => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
