require File.dirname(__FILE__) + '/../test_helper'
require 'roleinjobposition_controller'

# Re-raise errors caught by the controller.
class RoleinjobpositionController; def rescue_action(e) raise e end; end

class RoleinjobpositionControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :roleinjobpositions

  def setup
    @controller = RoleinjobpositionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:roleinjobposition]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:roleinjobposition]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Roleinjobposition.count
    create_roleinjobposition
    assert_response :redirect
    assert_equal old_count+1, Roleinjobposition.count
  end

  def test_should_require_login_on_signup
    old_count = Roleinjobposition.count
    create_roleinjobposition(:login => nil)
    assert assigns(:roleinjobposition).errors.on(:login)
    assert_response :success
    assert_equal old_count, Roleinjobposition.count
  end

  def test_should_require_password_on_signup
    old_count = Roleinjobposition.count
    create_roleinjobposition(:password => nil)
    assert assigns(:roleinjobposition).errors.on(:password)
    assert_response :success
    assert_equal old_count, Roleinjobposition.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Roleinjobposition.count
    create_roleinjobposition(:password_confirmation => nil)
    assert assigns(:roleinjobposition).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Roleinjobposition.count
  end

  def test_should_require_email_on_signup
    old_count = Roleinjobposition.count
    create_roleinjobposition(:email => nil)
    assert assigns(:roleinjobposition).errors.on(:email)
    assert_response :success
    assert_equal old_count, Roleinjobposition.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:roleinjobposition]
    assert_response :redirect
  end
  
  protected
  def create_roleinjobposition(options = {})
    post :signup, :roleinjobposition => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
