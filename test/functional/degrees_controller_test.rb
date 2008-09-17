require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  DegreesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :degrees

   def setup
      @model = Degree
   end
end
