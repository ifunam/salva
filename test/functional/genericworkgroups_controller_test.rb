require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  GenericworkgroupsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :genericworkgroups

   def setup
      @model = Genericworkgroup
      super
   end
end
