require File.dirname(__FILE__) + '/../test_helper'
class SalvaControllerTest < Test::Unit::TestCase
  include Session


  def setup
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as('juana','maltiempo')
    @controller = @mycontroller
    @fixtures =  @myfixtures
    @badfixtures = @mybadfixtures
    @child= @children
    @classe=@class

  end
    def test_should_get_index
    catch :x  do
      throw :x if @controller.nil?
      get :index
      assert_response  :success
      assert_template 'list'
    end
  end

  def test_should_get_list
    catch :x  do
      throw :x if @controller.nil?
      get :list
      assert_response  :success
      assert_template 'list'
    end
  end

  def test_should_get_new
    catch :x  do
      throw :x if @controller.nil?
      get :new
      assert_response  :success
      assert_template 'new'
    end
  end

  def test_should_get_edit
    catch :x  do
      throw :x if @controller.nil?
     get :edit,  :id =>@fixtures[:id]
      assert_response  :success
      assert_template 'edit'
    end
  end

  def test_should_return_to_list_using_cancel_from_new
    catch :x  do
      throw :x if @controller.nil?
      get :new
      assert_response  :success
      assert_template 'new'
      get  :cancel
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end

  def test_should_return_to_list_using_cancel_from_edit
    catch :x  do
      throw :x if @controller.nil?
      get:edit,  :id =>@fixtures[:id]
      assert_response :success
      assert_template'edit'
      get :cancel
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end

  def test_should_post_into_create
    catch :x  do
      throw :x if @controller.nil?
      post :create, :edit => @fixtures
         if @child != nil
              busq = @classe.find(:first, :conditions => "name = '#{@fixtures[:name]}'")
              assert_response  :redirect
              assert_redirected_to :action => 'show', :id=> busq.id
          else
        assert_response  :redirect
        assert_redirected_to :action => 'list'
      end
    end
  end



   def test_should_post_into_create_bad_values
    catch :x  do
      throw :x if @controller.nil?
      post :create, :edit => @badfixtures
      assert_response  :success
      assert_template 'new'
    end
  end


  def test_should_post_into_update
    catch :x  do
      throw :x if @controller.nil?
      post :update, :id=>@fixtures[:id], :edit => @fixtures
      if @child != nil
         busq = @classe.find(:first, :conditions => "name = '#{@fixtures[:name]}'")
         assert_response  :redirect
         assert_redirected_to :action => 'show', :id=> busq.id
      else
        assert_response  :redirect
        assert_redirected_to :action => 'list'
      end
    end
  end

  def test_should_post_into_update_bad_values
    catch :x  do
      throw :x if @controller.nil?
      post :update, :id=> @fixtures[:id], :edit => @badfixtures
      assert_response :success
      assert_template 'edit'
   end
  end


  def test_should_get_show
    catch :x  do
      throw :x if @controller.nil?
      get :show, :id => @fixtures[:id]
      assert_response  :success
      assert_template  'show'
    end
  end

  def test_should_return_to_list_using_cancel_from_show
    catch :x  do
      throw :x if @controller.nil?
      get :show,   :id => @fixtures[:id]  # @fixtures
      assert_response :success
      assert_template'show'
      get :back
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end


  def test_should_destroy_an_item
    catch :x  do
      throw :x if @controller.nil?
      get :purge_selected,   :id =>@fixtures[:id]  # @fixture.id
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end

  def test_should_destroy_all
# puts @fixtures[:id]
 catch :x  do
      throw :x if @controller.nil?
      get :purge,  :id =>@fixtures[:id] # @fixture.id
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end
end
