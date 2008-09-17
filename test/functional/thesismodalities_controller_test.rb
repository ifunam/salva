require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ThesismodalitiesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :thesismodalities

   def setup
      @model = Thesismodality
   end
end
