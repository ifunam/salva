require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  TalktypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :talktypes

   def setup
      @model = Talktype
      super
   end
end
