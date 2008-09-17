require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  TalkacceptancesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :talkacceptances

   def setup
      @model = Talkacceptance
   end
end
