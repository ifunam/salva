require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  ArticlestatusesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :articlestatuses

   def setup
      @model = Articlestatus
      super
   end
end
