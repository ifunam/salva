require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  LanguagesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :languages

   def setup
      @model = Language
   end
end
