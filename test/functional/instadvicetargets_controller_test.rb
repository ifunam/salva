require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  InstadvicetargetsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :instadvicetargets

   def setup
      @model = Instadvicetarget
      super
   end
end
