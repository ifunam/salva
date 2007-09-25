require File.dirname(__FILE__) + '/../test_helper'
require 'person_controller'

# Re-raise errors caught by the controller.
class PersonController; def rescue_action(e) raise e end; end

class PersonControllerTest < Test::Unit::TestCase
   include Session
  fixtures :userstatuses, :users, :countries, :states, :cities, :maritalstatuses, :people

  def setup
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as('juana','maltiempo')
    @controller = PersonController.new
    @model = Person
  end

  def test_get_new
      get :new
      assert_response :success
  end

  def test_get_show
    get :show, :id => @model.find(:first).id
    assert_response  :success
    assert_template  'show'
  end

  def test_get_edit
    get :edit,  :id => @model.find(:first).id
    assert_response  :success
    assert_template 'edit'
  end
end
