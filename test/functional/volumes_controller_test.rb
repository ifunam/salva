require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  VolumesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :volumes

   def setup
      @model = Volume
      super
   end
end
