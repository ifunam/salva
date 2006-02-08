require File.dirname(__FILE__) + '/../test_helper'

class CityTest < Test::Unit::TestCase
  fixtures :cities

  # Replace this with your real tests.
  def test_truth
    assert_kind_of City, cities(:first)
  end
end
