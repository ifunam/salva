require File.dirname(__FILE__) + '/../test_helper'

class PrizetypesControllerTest < ActionController::TestCase

  fixtures :prizetypes

  def setup
    @model = Prizetype
  end

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

  test "should create #{@model}" do
    assert_difference("#{@model}.count") do
      post :create, hash_name => @model.valid_hash
    end
    assert_redirected_to index_path
  end

  test "should not create existent #{@model}" do
    assert_difference("#{@model}.count") do
      post :create, hash_name => @model.build_valid.attributes
    end
    assert_redirected_to new_path
  end

  test "should create #{@model} based on rjs" do
    assert_difference("#{@model}.count") do
      xhr :post, :create, hash_name => @model.valid_hash
    end
    assert_response :success
  end

  test "should not create existent #{@model} based on rjs" do
    assert_difference("#{@model}.count") do
      xhr :post, :create, hash_name => @model.build_valid.attributes
    end
    assert_response :success
  end

  test "should show #{@model}" do
    get :show, :id => @model.first.id
    assert_response :success
  end

  test "should get edit #{@model}" do
    get :edit, :id => @model.first.id
    assert_response :success
  end

  test "should update #{@model}" do
    put :update, :id => @model.first.id, hash_name => @model.valid_hash
    assert_redirected_to index_path
  end

  test "should not update #{@model}" do
    put :update, :id => @model.first.id, hash_name => @model.invalid_hash
    assert_redirected_to edit_path(@model.first)
  end

  test "should update #{@model} based on rjs" do
    xhr :post, :update, :id => @model.first.id, hash_name => @model.valid_hash
    assert_response :success
  end

  test "should not update #{@model} based on rjs" do
    xhr :post, :update, :id => @model.first.id, hash_name => @model.invalid_hash
    assert_response :success
  end

  test "should destroy #{@model}" do
    assert_difference("#{@model}.count", -1) do
      delete :destroy, :id => @model.first.id
    end
    assert_redirected_to index_path
  end

  test "should destroy #{@model} based on rjs" do
    assert_difference("#{@model}.count", -1) do
      xhr :post, :destroy, :id => @model.first.id
    end
    assert_response :success
  end

  test "should destroy_all ID's #{@model}" do
    assert_difference("#{@model}.count", -@model.all.size) do
      post :destroy_all, :id => @model.all.collect { |record| record.id }
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

  def hash_name
    ActiveSupport::Inflector.tableize(@model).singularize.to_sym
  end
end

