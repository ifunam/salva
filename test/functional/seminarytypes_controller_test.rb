require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  SeminarytypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :seminarytypes

   def setup
      @model = Seminarytype
      super
   end
end
