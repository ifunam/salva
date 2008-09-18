require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  IndivadvicetargetsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :indivadvicetargets

   def setup
      @model = Indivadvicetarget
      super
   end
end
