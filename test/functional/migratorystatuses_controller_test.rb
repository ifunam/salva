require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  MigratorystatusesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :migratorystatuses

   def setup
      @model = Migratorystatus
      super
   end
end
