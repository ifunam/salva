require File.expand_path(File.dirname(__FILE__) + "/../super_scaffold_test_helper")
class PrizetypesControllerTest < ActionController::TestCase
  include SuperScaffoldTestHelper
  fixtures :prizetypes

  def setup
    @model = Prizetype
  end

end

