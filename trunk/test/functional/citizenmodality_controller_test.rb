require File.dirname(__FILE__) + '/../test_helper'
require 'citizenmodality_controller'

# Re-raise errors caught by the controller.
class CitizenmodalityController; def rescue_action(e) raise e end; end

class CitizenmodalityControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :citizenmodalities

  def setup
    @controller = CitizenmodalityController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:citizenmodality]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:citizenmodality]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Citizenmodality.count
    create_citizenmodality
    assert_response :redirect
    assert_equal old_count+1, Citizenmodality.count
  end

  def test_should_require_login_on_signup
    old_count = Citizenmodality.count
    create_citizenmodality(:login => nil)
    assert assigns(:citizenmodality).errors.on(:login)
    assert_response :success
    assert_equal old_count, Citizenmodality.count
  end

  def test_should_require_password_on_signup
    old_count = Citizenmodality.count
    create_citizenmodality(:password => nil)
    assert assigns(:citizenmodality).errors.on(:password)
    assert_response :success
    assert_equal old_count, Citizenmodality.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Citizenmodality.count
    create_citizenmodality(:password_confirmation => nil)
    assert assigns(:citizenmodality).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Citizenmodality.count
  end

  def test_should_require_email_on_signup
    old_count = Citizenmodality.count
    create_citizenmodality(:email => nil)
    assert assigns(:citizenmodality).errors.on(:email)
    assert_response :success
    assert_equal old_count, Citizenmodality.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:citizenmodality]
    assert_response :redirect
  end
  
  protected
  def create_citizenmodality(options = {})
    post :signup, :citizenmodality => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
