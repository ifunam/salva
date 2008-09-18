require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  AcademicprogramtypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :academicprogramtypes

   def setup
      @model = Academicprogramtype
      super
   end
end
