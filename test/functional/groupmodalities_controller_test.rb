require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  GroupmodalitiesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :groupmodalities

   def setup
      @model = Groupmodality
   end
end
