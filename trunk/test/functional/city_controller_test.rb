require File.dirname(__FILE__) + '/../test_helper'
require 'city_controller'

# Re-raise errors caught by the controller.
class CityController; def rescue_action(e) raise e end; end

class CityControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :cities

  def setup
    @controller = CityController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:city]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:city]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = City.count
    create_city
    assert_response :redirect
    assert_equal old_count+1, City.count
  end

  def test_should_require_login_on_signup
    old_count = City.count
    create_city(:login => nil)
    assert assigns(:city).errors.on(:login)
    assert_response :success
    assert_equal old_count, City.count
  end

  def test_should_require_password_on_signup
    old_count = City.count
    create_city(:password => nil)
    assert assigns(:city).errors.on(:password)
    assert_response :success
    assert_equal old_count, City.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = City.count
    create_city(:password_confirmation => nil)
    assert assigns(:city).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, City.count
  end

  def test_should_require_email_on_signup
    old_count = City.count
    create_city(:email => nil)
    assert assigns(:city).errors.on(:email)
    assert_response :success
    assert_equal old_count, City.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:city]
    assert_response :redirect
  end
  
  protected
  def create_city(options = {})
    post :signup, :city => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
