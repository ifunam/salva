require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinregularcoursesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleinregularcourses

   def setup
      @model = Roleinregularcourse
      super
   end
end
