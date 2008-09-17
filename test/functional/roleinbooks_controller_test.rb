require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinbooksControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleinbooks

   def setup
      @model = Roleinbook
   end
end
