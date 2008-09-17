require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  RoleproceedingsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :roleproceedings

   def setup
      @model = Roleproceeding
   end
end
