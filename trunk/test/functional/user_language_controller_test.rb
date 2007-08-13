require File.dirname(__FILE__) + '/../test_helper'
require 'user_language_controller'

class UserLanguageControllerTest < Test::Unit::TestCase
  fixtures :userstatuses, :users
  include Session

  def setup
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as('juana','maltiempo')
    @controller = UserLanguageController.new
    @fixtures =  {
      :language => 'Inglés',
      :spoken_languagelevel =>  'Intermedio',
      :written_languagelevel => 'Avanzado'
    }
  end
  
  def test_index
    get :index
    assert_response  :success
    assert_template 'list'
  end

  def test_new
    get :new
    assert_response  :success
    assert_template 'new'
  end

end
