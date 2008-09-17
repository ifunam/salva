require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinchaptersControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleinchapters

   def setup
      @model = Roleinchapter
   end
end
