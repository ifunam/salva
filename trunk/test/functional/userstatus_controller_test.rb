require File.dirname(__FILE__) + '/../test_helper'
require 'userstatus_controller'
require 'user_controller'


module Session
  def test_user_login(user,password,return_to='/user/login')
    @controller = UserController.new
    get :index
    assert_response :success
      #      @request.session['return-to'] = return_to
    #      post :login, :edit => { 'login' => 'admin', 'passwd' => 'maltiempo' }
    #      assert_session_has :user
    #      assert_equal User.find_by_login('admin').id, @response.session[:user].id
  end
end



# Re-raise errors caught by the controller.
class UserstatusController; def rescue_action(e) raise e end; end

class UserstatusControllerTest < Test::Unit::TestCase
  # fixtures :userstatuses
  include Session
  
  def setup
    @default_users = %w(admin juana panchito)
    @controller = UserstatusController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_index
    test_user_login('admin', 'maltiempo')
#    get :index
#    assert_response :success
#    assert_template 'list'
  end

#   def test_login
#     get :list

#     assert_response :success
#     assert_template 'login'

#     assert_not_nil assigns(:userstatus)
#   end

#   def test_show
#     get :show, :id => 1

#     assert_response :success
#     assert_template 'show'

#     assert_not_nil assigns(:userstatus)
#     assert assigns(:userstatus).valid?
#   end

#   def test_new
#     get :new

#     assert_response :success
#     assert_template 'new'

#     assert_not_nil assigns(:userstatus)
#   end

#   def test_create
#     num_userstatus = Userstatus.count

#     post :create, :edit => { :name => 'x'}

#     assert_response :redirect
#     assert_redirected_to :action => 'list'

#     assert_equal num_userstatus + 1, Userstatus.count
#   end

#   def test_edit
#     get :edit, :id => 1

#     assert_response :success
#     assert_template 'edit'

#     assert_not_nil assigns(:userstatus)
#     assert assigns(:userstatus).valid?
#   end

#   def test_update
#     post :update, :id => 1
#     assert_response :redirect
#     assert_redirected_to :action => 'show', :id => 1
#   end

#   def test_destroy
#     assert_not_nil Userstatus.find(1)

#     post :destroy, :id => 1
#     assert_response :redirect
#     assert_redirected_to :action => 'list'

#     assert_raise(ActiveRecord::RecordNotFound) {
#       Userstatus.find(1)
#     }
#   end
end
