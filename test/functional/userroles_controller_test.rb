require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  UserrolesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :userroles

   def setup
      @model = Userrole
      super
   end
end
