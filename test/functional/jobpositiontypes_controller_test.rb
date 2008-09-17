require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  JobpositiontypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :jobpositiontypes

   def setup
      @model = Jobpositiontype
   end
end
