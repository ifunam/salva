require File.dirname(__FILE__) + '/../test_helper'
require 'address_controller'

# Re-raise errors caught by the controller.
class Address_Controller; def rescue_action(e) raise e end; end

class Address_ControllerTest < Test::Unit::TestCase
  include Session
  fixtures :userstatuses, :users, :countries, :states, :cities, :addresstypes

  def setup
    @controller = AddressController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_get_list
    login_as('juana','maltiempo')
    @controller = AddressController.new
    get :list
    assert_response :success
    assert_template 'list'
  end
end

