require File.dirname(__FILE__) + '/../test_helper'
require 'user_controller'

# Re-raise errors caught by the controller.
class UserController; def rescue_action(e) raise e end; end

class UserControllerTest < Test::Unit::TestCase
  fixtures :users
  
  def setup
    @default_users = { 'admin' => 'maltiempo', 'juana' => 'maltiempo', 'panchito' => 'maltiempo' }
    @controller = UserController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_login_form
    get :login
    assert_response :success
    assert_template 'login'
  end
  
  def test_login_user
    @default_users.keys.each { |user|
      post :login, :user => { :login => user, :passwd => @default_users[user] }
      assert_not_nil session[:user]
      assert_equal User.find_by_login(user).id, session[:user]
      assert_response :redirect
      assert_redirected_to :controller => 'navigator'
    }
  end
  
  def test_bad_login_user
    @default_users.keys.each { |user|
      post :login, :user => { :login => user, :passwd => 'x'}
      assert_not_nil !session[:user]
      assert_response :success
      assert_template 'login'
    }
  end

  def test_new_form
    get :new
    assert_response :success
    assert_template 'new'
  end

  def test_create_user
    post :create, :user => { :login => 'martita', :passwd => 'sahagundefox', :passwd_confirmation => 'sahagundefox', :email => 'martha@notiene.ma.il' }
    assert_response :success
    assert_template 'create'
  end

  def test_create_bad_user
    post :create, :user => { :login => 'martita', :passwd => 'foxESdesahagun', :passwd_confirmation => 'sahagundefox', :email => 'notiene.ma.il' }
    assert_response :success
    assert_template 'new'
  end

  def test_forgot_password_form
    get :forgot_password
    assert_response :success
    assert_template 'forgot_password'
  end


  def test_forgot_password
    post :forgot_password,  :user => { :email => 'alexjr85@gmail.com' }
    assert_response :success
    assert_template 'forgot_password_done'
  end

  def test_forgot_password_bad_email
    post :forgot_password,  :user => { :email => 'alexj@gmail.com' }
    assert_response :success
    assert_template 'forgot_password'
  end

  # Pending tests: 
  # Use the activate action with valid and wrong values

end
