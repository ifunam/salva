require File.dirname(__FILE__) + '/../test_helper'

class SessionsControllerTest < ActionController::TestCase
  fixtures :userstatuses, :users

  context "on GET to :index" do
    setup do
      get :index
    end
    should_respond_with :success
    should_render_template :index
  end

  context "on POST to :login with valid login and valid password" do
      setup do
        post :login, :user => { :login => 'alex', :passwd => 'maltiempo' }
      end
   
      should_redirect_to "prizetypes_path"
      should "set user id in session" do
        assert_equal User.find_by_login('alex').id, session[:user_id]
        assert_equal "Bienvenido(a), ha iniciado una sesión en el SALVA!", flash[:notice]
      end
    end
   
    context "on POST to :login with invalid login and invalid password" do
      setup do
        post :login, :user => { :login => 'unexistent_login', :passwd => 'bad_password' }
      end
   
      should_respond_with :success
      should_render_template :index
      should "set user id in session" do
        assert_nil  session[:user_id]
        assert_equal "El login o el password es incorrecto!", flash[:notice]
      end
    end
   
    context "on GET to :login_by_token with valid login and valid token" do
      setup do
        get :login_by_token, :login => 'john.smith', :token => 'lcGVrs2FmS'
      end
      should_redirect_to "edit_change_password_path"
      should "set user id in session" do
        assert_equal User.find_by_login('john.smith').id, session[:user_id]
        assert_equal "Bienvenido(a), por favor cambie su contraseña...", flash[:notice]
      end
    end
   
    context "on GET to :login_by_token with invalid login or invalid token" do
      setup do
        get :login_by_token, :login => 'john.smith', :token => '1jkaj23lasjas'
      end
   
      should_respond_with :success
      should_render_template :index
      should "set user id in session" do
        assert_nil  session[:user_id]
        assert_equal "La información es inválida!", flash[:notice]
      end
    end
   
    context "on DELETE to :destroy" do
      setup do
        delete :destroy, {}, :user_id => User.find_by_login('alex').id
      end
   
      should_respond_with :success
      should_render_template :logout
      should "remove user id from session" do
        assert_nil session[:user_id]
      end
    end
end
