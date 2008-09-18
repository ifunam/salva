require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ProjecttypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :projecttypes

   def setup
      @model = Projecttype
      super
   end
end
