require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ConferencetypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :conferencetypes

   def setup
      @model = Conferencetype
      super
   end
end
