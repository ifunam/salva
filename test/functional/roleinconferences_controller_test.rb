require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinconferencesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleinconferences

   def setup
      @model = Roleinconference
   end
end
