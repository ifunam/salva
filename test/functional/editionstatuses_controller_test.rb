require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  EditionstatusesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :editionstatuses

   def setup
      @model = Editionstatus
   end
end
