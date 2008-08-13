require File.dirname(__FILE__) + '/../test_helper'
require 'change_password_controller'

# Re-raise errors caught by the controller.
class ChangePasswordController; def rescue_action(e) raise e end; end

class ChangePasswordControllerTest < Test::Unit::TestCase
   include Session
  fixtures :userstatuses, :users

  def setup
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as('juana','maltiempo')
    @controller = ChangePasswordController.new
  end

  def test_should_get_edit
      get :edit
      assert_response :success
  end
end
