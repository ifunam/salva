require File.expand_path(File.dirname(__FILE__) + "/../super_scaffold_test_helper")
class AcadvisittypesControllerTest < ActionController::TestCase
  include SuperScaffoldTestHelper
  fixtures :acadvisittypes

  def setup
    @model = Acadvisittype
  end

end

