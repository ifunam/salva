require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  CitizenmodalitiesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :citizenmodalities

   def setup
      @model = Citizenmodality
      super
   end
end
