require File.dirname(__FILE__) + '/../test_helper'
class SalvaControllerTest < Test::Unit::TestCase
  include Session
  fixtures :userstatuses, :users

  def setup
    @request     = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as('juana','maltiempo')
    @controller = @mycontroller
  end

  def test_should_get_index
    catch :abort  do
      throw :abort if @controller.nil?
      get :index
      assert_response  :success
      assert_template 'list'
    end
  end

  def test_should_get_list
    catch :abort  do
      throw :abort if @controller.nil?
      get :list
      assert_response  :success
      assert_template 'list'
    end
  end

  def test_should_get_new
    catch :abort  do
      throw :abort if @controller.nil?
      get :new
      assert_response  :success
      assert_template 'new'
    end
  end

  def test_should_get_edit
    catch :abort  do
      throw :abort if @controller.nil?
      get :edit,  :id => @model.find(:first).id
      assert_response  :success
      assert_template 'edit'
    end
  end

  def test_should_return_to_list_using_cancel_from_new
    catch :abort  do
      throw :abort if @controller.nil?
      get :new
      assert_response  :success
      assert_template 'new'
      get  :cancel
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end

  def test_should_return_to_list_using_cancel_from_edit
    catch :abort  do
      throw :abort if @controller.nil?
      get:edit,  :id => @model.find(:first).id
      assert_response :success
      assert_template'edit'
      get :cancel
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end

  def test_should_post_into_create
    catch :abort  do
      throw :abort if @controller.nil?
      post :create, :edit => @myfixtures
      if @children != nil
        record = @model.find(:first, :conditions => "name = '#{@myfixtures[:name]}'")
        assert_response  :redirect
        assert_redirected_to :action => 'show', :id=> record.id
      else
        assert_response  :redirect
        assert_redirected_to :action => 'list'
      end
    end
  end

  def test_should_post_into_create_bad_values
    catch :abort  do
      throw :abort if @controller.nil?
      post :create, :edit => @mybadfixtures
      assert_response  :success
      assert_template 'new'
    end
  end

  def test_should_post_into_update
    catch :abort  do
      throw :abort if @controller.nil?
      post :update, :id=> @model.find(:first).id, :edit => @myfixtures
      if @child != nil
        record = @model.find(:first, :conditions => "name = '#{@myfixtures[:name]}'")
        assert_response  :redirect
        assert_redirected_to :action => 'show', :id=> record.id
      else
        assert_response  :redirect
        assert_redirected_to :action => 'list'
      end
    end
  end

  def test_should_post_into_update_bad_values
    catch :abort  do
      throw :abort if @controller.nil?
      post :update, :id=> @model.find(:first).id, :edit => @mybadfixtures
      assert_response :success
      assert_template 'edit'
    end
  end

  def test_should_get_show
    catch :abort  do
      throw :abort if @controller.nil?
      get :show, :id => @model.find(:first).id
      assert_response  :success
      assert_template  'show'
    end
  end

  def test_should_return_to_list_using_cancel_from_show
    catch :abort  do
      throw :abort if @controller.nil?
      get :show,   :id => @model.find(:first).id
      assert_response :success
      assert_template 'show'
      get :back
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end


  def test_should_destroy_an_item
    catch :abort  do
      throw :abort if @controller.nil?
      get :purge_selected,   :id => @model.find(:first).id
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end

  def test_should_destroy_all_using_list
    catch :abort  do
      throw :abort if @controller.nil?
      get :list
      assert_response :success
      assert_template 'list'
      ids = @model.find(:all).collect  { |record| record.id}
      post :purge_selected,  :item => ids
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end

  def  test_should_add_an_item_using_quickpost_from_new_action
    catch :abort  do
      throw :abort if @controller.nil? || @quickposts.nil?
      get :new
      assert_template 'new'
      @quickposts.each do |qp|
        controller = qp
        controller = qp.split(':').first if qp =~ /:/
        controller = qp.split(',').first if qp =~ /,/
        post :create, :edit => @myfixtures , :stack => qp
        assert_redirected_to :controller => controller, :action => 'new'
    end
    end
  end

end
