require File.dirname(__FILE__) + '/../test_helper'
require 'jobposition_log_controller'

class JobpositionLogController; def rescue_action(e) raise e end; end

class JobpositionLogControllerTest < Test::Unit::TestCase
  include Session
  fixtures :userstatuses, :users #:jobposition_logs 

  def setup
    @request     = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as('panchito','maltiempo')
    @controller =  JobpositionLogController.new
   @fixtures = {:worker_key => 123789456, :academic_years => 1, :administrative_years => 2 }
   @badfixtures = {:worker_key => nil, :academic_years => 1, :administrative_years => nil }
   @model = JobpositionLog
  end

 def test_should_get_index_with_jobpostion_log
   get :index
   assert_response  :success
   assert_template 'new'
 end

def test_should_get_index_without_jobpostion_log
   @model.new({ :worker_key => 6788345290, :academic_years => 20, :administrative_years => 10})
   @model.save 
    get :index
    assert_response  :redirect
    assert_redirected_to :action => 'show'
end

  def test_should_get_new
      get :new
      assert_response  :success
      assert_template 'new'
  end

  def test_should_get_edit
      get :edit,  :id => @model.find(:first).id
      assert_response  :success
      assert_template 'edit'
  end

 #  def test_should_return_to_list_using_cancel_from_edit
#     catch :abort  do
#       throw :abort if @controller.nil?
#       get:edit,  :id => @model.find(:first).id
#       assert_response :success
#       assert_template'edit'
#       get :cancel
#       assert_response  :redirect
#       assert_redirected_to :action => 'list'
#     end
#   end

  def test_should_post_into_create
    @jobposition_log= @model.find(:first, :conditions => [ "user_id = ?", 3])
    if @jobposition_log.nil?
      post :create, :edit => @fixtures
      assert_response  :redirect
      assert_redirected_to :action => 'list'#'show', :id => @model.find(:first).id
   else
      puts 'ponme nil'
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
       assert_response  :redirect
       assert_redirected_to :action => 'list'
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
      post :purge_selected,  :item => ids.sort.reverse
      assert_response  :redirect
      assert_redirected_to :action => 'list'
    end
  end

  def  test_should_add_an_item_using_quickpost_from_new_action
    catch :abort  do
      throw :abort if @controller.nil? or @quickposts.nil?
      get :new
      assert_template 'new'
      @quickposts.each do |qp|
        # post :create, :edit => @myfixtures , :stack => qp
        controller = qp
        controller = qp.split(':').first if qp =~ /:/
        controller = qp.split(',').first if qp =~ /,/
        #assert_redirected_to :controller => controller, :action => 'new'
      end
    end
  end

end
