require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  TitlemodalitiesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :titlemodalities

   def setup
      @model = Titlemodality
   end
end
