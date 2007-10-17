require File.dirname(__FILE__) + '/../test_helper'
require 'userstatus'

class UserstatusTest < Test::Unit::TestCase
  fixtures :userstatuses
  include UnitSimple

  def setup
    @user_status = %w(new activated locked xfiles)
  end

  def test_crud 
    crud_test(@user_status, Userstatus)
  end

  def test_validation
    validate_test(@user_status, Userstatus)
  end

  def test_collision
    collision_test(@user_status, Userstatus)
  end
end
