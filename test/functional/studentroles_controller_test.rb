require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  StudentrolesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :studentroles

   def setup
      @model = Studentrole
      super
   end
end
