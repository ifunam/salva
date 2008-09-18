require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinprojectsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleinprojects

   def setup
      @model = Roleinproject
      super
   end
end
