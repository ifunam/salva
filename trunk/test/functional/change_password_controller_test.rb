require File.dirname(__FILE__) + '/../test_helper'
require 'change_password_controller'

# Re-raise errors caught by the controller.
class ChangePasswordController; def rescue_action(e) raise e end; end

class ChangePasswordControllerTest < Test::Unit::TestCase
  fixtures :users
  
  def setup
    @default_users = { 'admin' => 'maltiempo', 'juana' => 'maltiempo', 'panchito' => 'maltiempo' }
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_login_user
    @default_users.keys.each { |user|
      @controller = UserController.new      
      post :login, :user => { :login => user, :passwd => @default_users[user] }
      assert_not_nil session[:user]
      assert_equal User.find_by_login(user).id, session[:user]
      @controller = ChangePasswordController.new      
      puts session[:user]
      get :edit
      assert_response :success
      assert_template 'edit'
    }
  end

  def test_login_user
    @default_users.keys.each { |user|
      @controller = UserController.new      
      post :login, :user => { :login => user, :passwd => @default_users[user] }
      assert_not_nil session[:user]
      assert_equal User.find_by_login(user).id, session[:user]
      @controller = ChangePasswordController.new      
      get :edit
      assert_response :success
      assert_template 'edit'
    }
  end

end
