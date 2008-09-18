require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  InstitutiontitlesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :institutiontitles

   def setup
      @model = Institutiontitle
      super
   end
end
