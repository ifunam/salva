require File.expand_path(File.dirname(__FILE__) + "/test_helper")
module SuperScaffoldTestHelper
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:collection)
  end

  def test_should_get_index_rendering_rjs
    xhr :get, :index
    assert_response :success
    assert_not_nil assigns(:collection)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_new_record
    assert_difference("#{@model}.count") do
      post :create, hash_name => @model.valid_hash
    end
    assert_redirected_to index_path
  end

  def test_should_not_create_existent_record
    assert_difference("#{@model}.count") do
      post :create, hash_name => @model.build_valid.attributes
    end
    assert_redirected_to new_path
  end

  def test_should_create_record_rendering_rjs
    assert_difference("#{@model}.count") do
      xhr :post, :create, hash_name => @model.valid_hash
    end
    assert_response :success
  end

  def test_should_not_create_existent_record_rendering_rjs
    assert_difference("#{@model}.count") do
      xhr :post, :create, hash_name => @model.build_valid.attributes
    end
    assert_response :success
  end

  def test_should_show_record
    get :show, :id => @model.first.id
    assert_response :success
  end

  def test_should_edit_record
    get :edit, :id => @model.first.id
    assert_response :success
  end

  def test_should_update_record
    put :update, :id => @model.first.id, hash_name => @model.valid_hash
    assert_redirected_to index_path
  end

  def test_should_not_update_record_with_invalid_params
    put :update, :id => @model.first.id, hash_name => @model.invalid_hash
    assert_redirected_to edit_path(@model.first)
  end

  def  test_should_update_record_rendering_rjs
    xhr :post, :update, :id => @model.first.id, hash_name => @model.valid_hash
    assert_response :success
  end

  def test_should_not_update_record_rendering_rjs
    xhr :post, :update, :id => @model.first.id, hash_name => @model.invalid_hash
    assert_response :success
  end

  def test_should_destroy_record
    assert_difference("#{@model}.count", -1) do
      delete :destroy, :id => @model.first.id
    end
    assert_redirected_to index_path
  end

  def test_should_destroy_record_rendering_rjs
     assert_difference("#{@model}.count", -1) do
       xhr :post, :destroy, :id => @model.first.id
     end
     assert_response :success
  end
  
  def test_should_destroy_all_records
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
