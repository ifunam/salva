require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase     
  fixtures :userstatuses, :users

  context "on GET to :index" do
    setup do
      get :index
    end
    should_respond_with :success
    #assert_not_nil @user
    should_render_template :new
  end

  context "on GET to :new" do
    setup do
      get :new
    end
    should_respond_with :success
    #assert_not_nil @user
    should_render_template :new
  end

  context "on POST to :create" do
    setup do
      assert_difference 'User.count', 1 do
        post :create, :user => User.valid_hash
      end      
    end

   # should_assign_to :user
    should_respond_with :success
    should_render_template :created
    should "create a new user" do
      assert_equal 'Su cuenta ha sido creada.', flash[:notice]
    end
  end

  context "on POST to :create" do
    setup do
      post :create, :user => { :login => 'mary', :passwd => 'abcd123', :passwd_confirmation => 'abcd12', :email => 'mary@nodomain.org'}
    end
    #should_assign_to :user
    should_respond_with :success
    should_render_template :new

    should "not create new user with bad password confirmation" do
      assert_equal 'La información de su cuenta es incorrecta.', flash[:notice]
    end
  end

  context "on GET to :confirm" do
    setup do
      get :confirm, :id => 3, :token=> 'lcGVrs2FmS'
    end
    should_respond_with :success
    should_render_template :activated
    should "activate user with valid token" do
      assert_equal 'Su cuenta ha sido activada.', flash[:notice]
    end
  end

  context "on GET to :confirm" do
    setup do
      get :confirm, :id => 3, :token=> 'BlaBlabla'
    end
    should_respond_with :success
    should_render_template :index
    should "not activate new user with invalid token" do
      assert_equal 'La liga para activar su cuenta ha expirado.', flash[:notice]
    end
  end

  context "on GET to :recovery_passwd_request" do
    setup do
      get :recovery_passwd_request
    end
    should_respond_with :success
    #assert_not_nil @user
    should_render_template :recovery_passwd_request
  end

  context "on POST to :recovery_passwd" do
    setup do
      post :recovery_passwd, :user => { :email => 'alex@fisica.unam.mx'}
    end

    should_respond_with :success
    should_render_template :recovery_passwd
  end

  context "on POST to :recovery_passwd" do
    setup do
      post :recovery_passwd, :user => { :email => 'unexistent@email.com'}
    end

    should_respond_with :success
    should_render_template :recovery_passwd_request

    should "send email with instructions to recover user password" do
      assert_equal "El correo unexistent@email.com NO existe en el sistema!", flash[:notice]
    end
  end
  
end