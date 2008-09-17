require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  MediatypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :mediatypes

   def setup
      @model = Mediatype
   end
end
