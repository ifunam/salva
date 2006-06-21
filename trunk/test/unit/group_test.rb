require File.dirname(__FILE__) + '/../test_helper'
require 'group'
class GroupTest < Test::Unit::TestCase
  fixtures :groups
  include UnitSimple

  def setup
    @user_groups = %w(salva sa)
  end

  def test_crud 
    crud_test(@user_groups, Group)
  end

  def test_validation
    validate_test(@user_groups, Group)
  end

  def test_collision
    collision_test(@user_groups, Group)
  end
end
