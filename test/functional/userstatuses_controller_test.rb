require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  UserstatusesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :userstatuses

   def setup
      @model = Userstatus
   end
end
