require File.expand_path(File.dirname(__FILE__) + "/../super_scaffold_test_helper")
class BooktypesControllerTest < ActionController::TestCase
  include SuperScaffoldTestHelper
  fixtures :booktypes

  def setup
    @model = Booktype
  end

end

