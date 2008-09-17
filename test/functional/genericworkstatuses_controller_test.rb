require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  GenericworkstatusesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :genericworkstatuses

   def setup
      @model = Genericworkstatus
   end
end
