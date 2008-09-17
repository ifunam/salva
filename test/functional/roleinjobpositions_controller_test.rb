require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinjobpositionsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleinjobpositions

   def setup
      @model = Roleinjobposition
   end
end
