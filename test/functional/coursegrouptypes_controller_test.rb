require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  CoursegrouptypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :coursegrouptypes

   def setup
      @model = Coursegrouptype
      super
   end
end
