require File.dirname(__FILE__) + '/../test_helper'
class SalvaControllerTest < Test::Unit::TestCase
  include Session

  def setup
    @request     = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as('juana','maltiempo')

    @controller = @mycontroller
    # @children = @controller.new.children if @controller.respond_to? 'children'
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
      get :edit,  :id =>@fixtures[:id]
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
      get:edit,  :id =>@fixtures[:id]
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
      post :create, :edit => @fixtures
      if @children != nil
        record = @model.find(:first, :conditions => "name = '#{@fixtures[:name]}'")
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
      post :create, :edit => @badfixtures
      assert_response  :success
      assert_template 'new'
    end
  end

  def test_should_post_into_update
    catch :abort  do
      throw :abort if @controller.nil?
      post :update, :id=>@fixtures[:id], :edit => @fixtures
      if @child != nil
        record = @model.find(:first, :conditions => "name = '#{@fixtures[:name]}'")
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
      post :update, :id=> @fixtures[:id], :edit => @badfixtures
      assert_response :success
      assert_template 'edit'
    end
  end

  def test_should_get_show
    catch :abort  do
      throw :abort if @controller.nil?
      get :show, :id => @fixtures[:id]
      assert_response  :success
      assert_template  'show'
    end
  end

  def test_should_return_to_list_using_cancel_from_show
    catch :abort  do
      throw :abort if @controller.nil?
      get :show,   :id => @fixtures[:id]  # @fixtures
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
      get :purge_selected,   :id =>@fixtures[:id]  # @fixture.id
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end

  def test_should_destroy_all
    # puts @fixtures[:id]
    catch :abort  do
      throw :abort if @controller.nil?
      get :purge,  :id =>@fixtures[:id] # @fixture.id
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end

  def teardown
   catch :abort  do
      throw :abort if @controller.nil?
      @model.destroy_all if  @model.find(:all).size > 0
   end
  end
end
