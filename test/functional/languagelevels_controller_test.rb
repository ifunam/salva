require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  LanguagelevelsControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :languagelevels

   def setup
      @model = Languagelevel
      super
   end
end
