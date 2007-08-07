require File.dirname(__FILE__) + '/../test_helper'
class SalvaControllerTest < Test::Unit::TestCase
  include Session

  def setup
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as('juana','maltiempo')
    @controller = @mycontroller
    exit if  @controller.nil?
    @fixtures =  @myfixtures
  end

  def test_should_get_index
    get :index
    assert_response  :success
    assert_template 'list'
  end

  def test_should_get_list
    get :list
    assert_response  :success
    assert_template 'list'
  end

  def test_should_get_new
    get :new
    assert_response  :success
    assert_template 'new'
  end

   def test_should_post_into_create
     post :create, :edit => @fixtures
     assert_response  :redirect
     assert_redirected_to :action => 'list'
   end

   def test_should_return_to_list_using_cancel_from_new
     get :new
     assert_response  :success
     assert_template 'new'
     get  :cancel
     assert_response  :redirect
     assert_redirected_to :action => 'list'
   end

   def test_should_post_into_update
     post :update, :id=> 1, :edit => @fixtures
     assert_response  :redirect
     assert_redirected_to :action => 'list'
   end

#   def test_should_get_show
#     get :show, :id =>  2
#     assert_response  :success
#     assert_template 'edit'
#   end

#    def test_should_destroy_an_item
#      get :destroy,  :id => 1
#      assert_response  :redirect
#      assert_redirected_to :action => 'list'
#      assert_template 'list'
#    end

#   def test_should_destroy_all
#     get :destroy,  :ids => 1
#     assert_response  :redirect
#     assert_redirected_to :action => 'list'
#     assert_template 'list'
#  end
end
