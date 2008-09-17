require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinthesesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleintheses

   def setup
      @model = Roleinthesis
   end
end
