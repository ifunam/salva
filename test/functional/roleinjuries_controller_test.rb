require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinjuriesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleinjuries

   def setup
      @model = Roleinjury
      super
   end
end
