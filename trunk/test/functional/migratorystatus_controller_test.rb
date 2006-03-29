require File.dirname(__FILE__) + '/../test_helper'
require 'migratorystatus_controller'

# Re-raise errors caught by the controller.
class MigratorystatusController; def rescue_action(e) raise e end; end

class MigratorystatusControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :migratorystatuses

  def setup
    @controller = MigratorystatusController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:migratorystatus]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:migratorystatus]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Migratorystatus.count
    create_migratorystatus
    assert_response :redirect
    assert_equal old_count+1, Migratorystatus.count
  end

  def test_should_require_login_on_signup
    old_count = Migratorystatus.count
    create_migratorystatus(:login => nil)
    assert assigns(:migratorystatus).errors.on(:login)
    assert_response :success
    assert_equal old_count, Migratorystatus.count
  end

  def test_should_require_password_on_signup
    old_count = Migratorystatus.count
    create_migratorystatus(:password => nil)
    assert assigns(:migratorystatus).errors.on(:password)
    assert_response :success
    assert_equal old_count, Migratorystatus.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Migratorystatus.count
    create_migratorystatus(:password_confirmation => nil)
    assert assigns(:migratorystatus).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Migratorystatus.count
  end

  def test_should_require_email_on_signup
    old_count = Migratorystatus.count
    create_migratorystatus(:email => nil)
    assert assigns(:migratorystatus).errors.on(:email)
    assert_response :success
    assert_equal old_count, Migratorystatus.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:migratorystatus]
    assert_response :redirect
  end
  
  protected
  def create_migratorystatus(options = {})
    post :signup, :migratorystatus => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
