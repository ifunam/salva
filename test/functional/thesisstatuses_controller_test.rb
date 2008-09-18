require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ThesisstatusesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :thesisstatuses

   def setup
      @model = Thesisstatus
      super
   end
end
