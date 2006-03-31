require File.dirname(__FILE__) + '/../test_helper'
require 'institutiontype_controller'

# Re-raise errors caught by the controller.
class InstitutiontypeController; def rescue_action(e) raise e end; end

class InstitutiontypeControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :institutiontypes

  def setup
    @controller = InstitutiontypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:institutiontype]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:institutiontype]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Institutiontype.count
    create_institutiontype
    assert_response :redirect
    assert_equal old_count+1, Institutiontype.count
  end

  def test_should_require_login_on_signup
    old_count = Institutiontype.count
    create_institutiontype(:login => nil)
    assert assigns(:institutiontype).errors.on(:login)
    assert_response :success
    assert_equal old_count, Institutiontype.count
  end

  def test_should_require_password_on_signup
    old_count = Institutiontype.count
    create_institutiontype(:password => nil)
    assert assigns(:institutiontype).errors.on(:password)
    assert_response :success
    assert_equal old_count, Institutiontype.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Institutiontype.count
    create_institutiontype(:password_confirmation => nil)
    assert assigns(:institutiontype).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Institutiontype.count
  end

  def test_should_require_email_on_signup
    old_count = Institutiontype.count
    create_institutiontype(:email => nil)
    assert assigns(:institutiontype).errors.on(:email)
    assert_response :success
    assert_equal old_count, Institutiontype.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:institutiontype]
    assert_response :redirect
  end
  
  protected
  def create_institutiontype(options = {})
    post :signup, :institutiontype => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
