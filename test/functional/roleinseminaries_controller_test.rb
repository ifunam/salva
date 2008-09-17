require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinseminariesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleinseminaries

   def setup
      @model = Roleinseminary
   end
end
