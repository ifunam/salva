require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ProjectstatusesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :projectstatuses

   def setup
      @model = Projectstatus
      super
   end
end
