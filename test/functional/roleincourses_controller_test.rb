require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleincoursesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleincourses

   def setup
      @model = Roleincourse
   end
end
