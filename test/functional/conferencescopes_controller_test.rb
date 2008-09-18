require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ConferencescopesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :conferencescopes

   def setup
      @model = Conferencescope
      super
   end
end
