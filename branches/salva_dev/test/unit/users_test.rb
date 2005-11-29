require File.dirname(__FILE__) + '/../test_helper'

class UsersTest < Test::Unit::TestCase
  fixtures :users

  def setup
    @users = Users.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Users,  @users
  end
end
