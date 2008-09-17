require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  IdtypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :idtypes

   def setup
      @model = Idtype
   end
end
