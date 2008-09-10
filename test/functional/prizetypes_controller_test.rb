require File.dirname(__FILE__) + '/../test_helper'

class PrizetypesControllerTest < ActionController::TestCase

  fixtures :prizetypes

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:collection)
  end

  test "should get index rjs" do
    xhr :get, :index
    assert_response :success
    assert_not_nil assigns(:collection)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prizetype" do
    assert_difference('Prizetype.count') do
      post :create, :prizetype => Prizetype.build_valid.attributes
    end
    assert_response :success
  end

  test "should create prizetype rjs" do
    assert_difference('Prizetype.count') do
      xhr :post, :create, :prizetype => Prizetype.build_valid.attributes
    end
    assert_response :success
  end

  test "should show prizetype" do
    get :show, :id => prizetypes('diploma').id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => prizetypes('diploma').id
    assert_response :success
  end

  test "should update prizetype" do
    put :update, :id => prizetypes('diploma').id, :prizetype => Prizetype.build_valid.attributes

    assert_response :success
    # assert_redirected_to admin_prizetype_path(assigns(:prizetype))
  end

  test "should destroy prizetype" do
    assert_difference('Prizetype.count', -1) do
      delete :destroy, :id => prizetypes('diploma').id
    end
    assert_response :success
    # assert_redirected_to admin_prizetypes_path
  end
  
  test "should destroy_all ID's prizetype" do
    assert_difference('Prizetype.count', -Prizetype.all.size) do
      post :destroy_all, :id => Prizetype.all.collect {|record| record.id }
    end
    assert_response :success
  end
  
end