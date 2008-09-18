require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ContracttypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :contracttypes

   def setup
      @model = Contracttype
      super
   end
end
