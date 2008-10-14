require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  UserArticlesControllerTest < ActionController::TestCase
 def setup
     login_as('alex', 'maltiempo')
   end
    def test_should_get_new
      get :new
      assert_response :success
  end
end
