require File.expand_path(File.dirname(__FILE__) + "/../super_scaffold_test_helper")
class BookchaptertypesControllerTest < ActionController::TestCase
  include SuperScaffoldTestHelper
  fixtures :bookchaptertypes

  def setup
    @model = Bookchaptertype
  end

end

