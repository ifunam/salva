require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ExternaluserlevelsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :externaluserlevels

   def setup
      @model = Externaluserlevel
   end
end
