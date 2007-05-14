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
    @user = User.new({ :login => 'miguel', :passwd => 'hola123', :passwd_confirmation => 'hola123', :email => 'bachitas83@hotmail.com'} )
 end

  def test_login_form
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_login_user
    @default_users.keys.each { |user|
      post :index, :user => { :login => user, :passwd => 'maltiempo' }
      assert_not_nil session[:user], "no ha iniciado sesión"
      assert_equal User.find_by_login(user).id, session[:user], "No se encontro usuario"
      assert_response :redirect
      assert_redirected_to :controller => 'navigator'
    }
  end

  def test_bad_login_user
    @default_users.keys.each { |user|
      post :index, :user => { :login => user, :passwd => 'x'}
      assert_not_nil !session[:user]
      assert_response :success
      assert_template 'index'
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
    assert_template 'created'
  end

  def test_create_bad_user
    post :create, :user => { :login => 'martita', :passwd => 'foxESdesahagun', :passwd_confirmation => 'sahagundefox', :email => 'notiene.ma.il' }
    assert_response :success
    assert_template 'new'
  end

  def test_forgot_password_form
    get :forgotten_password_recovery
    assert_response :success
    assert_template 'forgotten_password_recovery'
  end


  def test_forgot_password
    post :forgotten_password_recovery,  :user => { :email => 'bachitas83@hotmail.com' }
    assert_response :success
    assert_template 'forgotten_password_recovery'
  end

  def test_forgot_password_bad_email
    post :forgotten_password_recovery,  :user => { :email => 'alexjasdaasds@gmail.com' }
    assert_response :success
    assert_template 'forgotten_password_recovery'
  end

  # Pending tests:
  # Use the activate action with valid and wrong values
  def test_activate_by_email
    post :password_recovery,  :user => { :email => 'alexjr85@gmail.com'}
    assert_response :success
    assert_template 'password_recovery'
  end

  def test_activate_by_email_bad_values
    post :password_recovery,  :user => { :email => 'alexjasdas@gmail.com' }
    assert_response :success
    assert_template 'forgotten_password_recovery'
  end

  def test_activate
   @default_users.keys.each { |user|
      @user = User.find(:first, :conditions => "login = '#{user}'")
      @user.new_token
      get :activate, {:id => @user.id, :token => @user.token}
      assert_equal @user.is_activated?, true
      assert_response :success
      assert_template 'activated'
   }
  end

#  def test_activate_with_bad_values
 #   post :password_recovery,  :user => { :email => 'alexjasdas@gmail.com' }
  #  assert_response :success
   # assert_template 'forgotten_password_recovery'
#  end

#  def test_signup_by_token
 #   @user.id=2
  #  @user.new_token
   # post :signup_by_token, :user => {:id => @user.id :token=> @user.token }
   # assert_response :redirect
   # assert_redirected_to :controller => 'change_password'
#  end
end
