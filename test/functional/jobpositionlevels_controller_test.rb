require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  JobpositionlevelsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :jobpositionlevels

   def setup
      @model = Jobpositionlevel
   end
end
