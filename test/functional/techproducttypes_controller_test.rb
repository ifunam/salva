require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  TechproducttypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :techproducttypes

   def setup
      @model = Techproducttype
   end
end
