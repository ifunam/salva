require File.dirname(__FILE__) + '/../test_helper'
require 'membership_controller'

# Re-raise errors caught by the controller.
class MembershipController; def rescue_action(e) raise e end; end

class MembershipControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :memberships

  def setup
    @controller = MembershipController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:membership]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:membership]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = Membership.count
    create_membership
    assert_response :redirect
    assert_equal old_count+1, Membership.count
  end

  def test_should_require_login_on_signup
    old_count = Membership.count
    create_membership(:login => nil)
    assert assigns(:membership).errors.on(:login)
    assert_response :success
    assert_equal old_count, Membership.count
  end

  def test_should_require_password_on_signup
    old_count = Membership.count
    create_membership(:password => nil)
    assert assigns(:membership).errors.on(:password)
    assert_response :success
    assert_equal old_count, Membership.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = Membership.count
    create_membership(:password_confirmation => nil)
    assert assigns(:membership).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, Membership.count
  end

  def test_should_require_email_on_signup
    old_count = Membership.count
    create_membership(:email => nil)
    assert assigns(:membership).errors.on(:email)
    assert_response :success
    assert_equal old_count, Membership.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:membership]
    assert_response :redirect
  end
  
  protected
  def create_membership(options = {})
    post :signup, :membership => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end
