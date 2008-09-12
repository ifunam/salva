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
      post :create, :prizetype => Prizetype.valid_hash
    end
    assert_redirected_to index_path
  end

  test "should not create existent prizetype" do
    assert_difference('Prizetype.count') do
      post :create, :prizetype => Prizetype.build_valid.attributes
    end
    assert_redirected_to new_path
  end

  test "should create prizetype based on rjs" do
    assert_difference('Prizetype.count') do
      xhr :post, :create, :prizetype => Prizetype.valid_hash
    end
    assert_response :success
  end

  test "should not create existent prizetype based on rjs" do
    assert_difference('Prizetype.count') do
      xhr :post, :create, :prizetype => Prizetype.build_valid.attributes
    end
    assert_response :success
  end

  test "should show prizetype" do
    get :show, :id => Prizetype.first.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => Prizetype.first.id
    assert_response :success
  end

  test "should update prizetype" do
    put :update, :id => Prizetype.first.id, :prizetype => Prizetype.valid_hash
    assert_redirected_to index_path
  end

  test "should not update prizetype" do
    put :update, :id => Prizetype.first.id, :prizetype => Prizetype.invalid_hash
    assert_redirected_to edit_path(Prizetype.first)
  end

  test "should update prizetype based on rjs" do
    xhr :post, :update, :id => Prizetype.first.id, :prizetype => Prizetype.valid_hash
    assert_response :success
  end

  test "should not update prizetype based on rjs" do
    xhr :post, :update, :id => Prizetype.first.id, :prizetype => Prizetype.invalid_hash
    assert_response :success
  end

  test "should destroy prizetype" do
    assert_difference('Prizetype.count', -1) do
      delete :destroy, :id => Prizetype.first.id
    end
    assert_redirected_to index_path
  end

  test "should destroy prizetype based on rjs" do
    assert_difference('Prizetype.count', -1) do
      xhr :post, :destroy, :id => Prizetype.first.id
    end
    assert_response :success
  end

  test "should destroy_all ID's prizetype" do
    assert_difference('Prizetype.count', -Prizetype.all.size) do
      post :destroy_all, :id => Prizetype.all.collect {|record| record.id }
    end
    assert_response :success
  end

  private
  
  def controller_name
    self.class.name.sub(/ControllerTest$/, '').downcase
  end

  def index_path
    self.send(controller_name + '_path')
  end
  
  def new_path
    self.send('new_' + ActiveSupport::Inflector.singularize(controller_name) + '_path')
  end
  
  def edit_path(record)
    self.send('edit_' + ActiveSupport::Inflector.singularize(controller_name) + '_path', record)
  end
end
