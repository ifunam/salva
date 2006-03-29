require File.dirname(__FILE__) + '/../test_helper'
require 'personalidtype_controller'

# Re-raise errors caught by the controller.
class PersonalidtypeController; def rescue_action(e) raise e end; end

class PersonalidtypeControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :personalidtypes

  def setup
    @controller = PersonalidtypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:personalidtype]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:personalidtype]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Personalidtype.count
    create_personalidtype
    assert_response :redirect
    assert_equal old_count+1, Personalidtype.count
  end

  def test_should_require_login_on_signup
    old_count = Personalidtype.count
    create_personalidtype(:login => nil)
    assert assigns(:personalidtype).errors.on(:login)
    assert_response :success
    assert_equal old_count, Personalidtype.count
  end

  def test_should_require_password_on_signup
    old_count = Personalidtype.count
    create_personalidtype(:password => nil)
    assert assigns(:personalidtype).errors.on(:password)
    assert_response :success
    assert_equal old_count, Personalidtype.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Personalidtype.count
    create_personalidtype(:password_confirmation => nil)
    assert assigns(:personalidtype).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Personalidtype.count
  end

  def test_should_require_email_on_signup
    old_count = Personalidtype.count
    create_personalidtype(:email => nil)
    assert assigns(:personalidtype).errors.on(:email)
    assert_response :success
    assert_equal old_count, Personalidtype.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:personalidtype]
    assert_response :redirect
  end
  
  protected
  def create_personalidtype(options = {})
    post :signup, :personalidtype => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
