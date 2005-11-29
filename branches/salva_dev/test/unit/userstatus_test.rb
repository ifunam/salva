require File.dirname(__FILE__) + '/../test_helper'

class UserstatusTest < Test::Unit::TestCase
  fixtures :userstatus

  def setup
    @userstatus = Userstatus.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Userstatus,  @userstatus
  end
end
