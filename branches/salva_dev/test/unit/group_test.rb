require File.dirname(__FILE__) + '/../test_helper'

class GroupTest < Test::Unit::TestCase
  fixtures :groups

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Group, groups(:first)
  end
end
