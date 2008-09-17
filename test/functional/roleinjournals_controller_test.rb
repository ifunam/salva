require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinjournalsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleinjournals

   def setup
      @model = Roleinjournal
   end
end
