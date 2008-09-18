require File.expand_path(File.dirname(__FILE__) + '/../super_scaffold_test_helper')
class  InstitutiontypesControllerTest < ActionController::TestCase
   include SuperScaffoldTestHelper
   fixtures :institutiontypes

   def setup
      @model = Institutiontype
      super
   end
end
