require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleinconferencetalksControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleinconferencetalks

   def setup
      @model = Roleinconferencetalk
   end
end
