require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  TechproductstatusesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :techproductstatuses

   def setup
      @model = Techproductstatus
   end
end
