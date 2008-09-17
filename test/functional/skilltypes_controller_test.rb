require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  SkilltypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :skilltypes

   def setup
      @model = Skilltype
   end
end
