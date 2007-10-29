require File.dirname(__FILE__) + '/../test_helper'
class ListTest < Test::Unit::TestCase
  include Session
  fixtures :userstatuses, :users

  def setup
    @request     = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as('juana','maltiempo')
    @controller = InstitutionController.new
  end
  
  def test_set_conditions_from_search_througt_list_action    
      get :list,  @controller.controller_name.to_sym => { :institutiontitle_id => 1, :institutiontype_id => 2 }
      assert @response.session[@controller.controller_name + '_list_conditions']
      assert_equal ["institutiontype_id = ? AND institutiontitle_id = ?", 2, 1], @response.session[@controller.controller_name + '_list_conditions']
      assert_response  :success
      assert_template 'list'
  end
  
  def test_set_conditions_from_search_with_empty_params_througt_list_action    
       get :list,  @controller.controller_name.to_sym => {} 
       assert @response.session[@controller.controller_name + '_list_conditions']
       assert_equal [""], @response.session[@controller.controller_name + '_list_conditions']
       assert_response  :success
       assert_template 'list'
   end
   
   def test_set_per_page_througt_list_action   
     # Revisar valores negativos, cero y valores nulos
       [ 30, 10, 5 ].each do | p|
         get :list, {:per_page => p }
         assert @response.session[@controller.controller_name + '_per_page']
         assert_equal p.to_i, @response.session[@controller.controller_name + '_per_page']
         assert_response  :success
         assert_template 'list'
       end
   end
   
end