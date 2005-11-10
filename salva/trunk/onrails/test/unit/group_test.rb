require File.dirname(__FILE__) + '/../test_helper'

class GroupTest < Test::Unit::TestCase
  fixtures :group

  def setup
    @group = Group.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Group,  @group
  end
end
