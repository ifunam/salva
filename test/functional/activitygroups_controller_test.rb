require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ActivitygroupsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :activitygroups

   def setup
      @model = Activitygroup
      super
   end
end
