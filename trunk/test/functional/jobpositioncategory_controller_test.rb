require File.dirname(__FILE__) + '/../test_helper'
require 'jobpositioncategory_controller'

# Re-raise errors caught by the controller.
class JobpositioncategoryController; def rescue_action(e) raise e end; end

class JobpositioncategoryControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :jobpositioncategories

  def setup
    @controller = JobpositioncategoryController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:jobpositioncategory]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:jobpositioncategory]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Jobpositioncategory.count
    create_jobpositioncategory
    assert_response :redirect
    assert_equal old_count+1, Jobpositioncategory.count
  end

  def test_should_require_login_on_signup
    old_count = Jobpositioncategory.count
    create_jobpositioncategory(:login => nil)
    assert assigns(:jobpositioncategory).errors.on(:login)
    assert_response :success
    assert_equal old_count, Jobpositioncategory.count
  end

  def test_should_require_password_on_signup
    old_count = Jobpositioncategory.count
    create_jobpositioncategory(:password => nil)
    assert assigns(:jobpositioncategory).errors.on(:password)
    assert_response :success
    assert_equal old_count, Jobpositioncategory.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Jobpositioncategory.count
    create_jobpositioncategory(:password_confirmation => nil)
    assert assigns(:jobpositioncategory).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Jobpositioncategory.count
  end

  def test_should_require_email_on_signup
    old_count = Jobpositioncategory.count
    create_jobpositioncategory(:email => nil)
    assert assigns(:jobpositioncategory).errors.on(:email)
    assert_response :success
    assert_equal old_count, Jobpositioncategory.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:jobpositioncategory]
    assert_response :redirect
  end
  
  protected
  def create_jobpositioncategory(options = {})
    post :signup, :jobpositioncategory => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
