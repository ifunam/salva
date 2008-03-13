require File.dirname(__FILE__) + '/../test_helper'
require 'addresses_controller'

class AddressesControllerTest < Test::Unit::TestCase
   include Session
   fixtures :userstatuses, :users, :countries, :states, :cities, :addresstypes,  :addresses

  def setup
    @request     = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
     login_as('juana','maltiempo')
     @controller = AddressesController.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:collection)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_address
    assert_difference('Address.count') do
      post :create, :address => {:location => "Tajín No. 6344, Int 1, Col. Letrán Valle, Delegación Benito Juárez", :zipcode => 03650,  :country_id => 484,  :state_id => 9,  :city_id => 64,  :addresstype_id =>  2, :is_postaddress=> true}

    end
    assert_redirected_to address_path(assigns(:record))
   end

  def test_should_show_address
    get :show, :id => Address.find(:first).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => Address.find(:first).id
    assert_response :success
  end

  def test_should_update_address
    put :update, :id => Address.find(:first).id, :address => {:location => "Clavel 50",:zipcode => 0364,  :country_id => 484,  :state_id => 9,  :city_id => 64,  :addresstype_id =>  3, :is_postaddress=> false}
    assert_equal 3, assigns(:record).addresstype_id
    assert_redirected_to address_path(assigns(:record))
  end

  def test_should_destroy_address
    assert_difference('Address.count', -1) do
      delete :destroy, :id => Address.find(:first).id
    end
    assert_redirected_to addresses_path
  end
end
