require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ModalitiesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :modalities

   def setup
      @model = Modality
      super
   end
end
