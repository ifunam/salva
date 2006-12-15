require File.dirname(__FILE__) + '/../test_helper'
require 'country'
require 'state'
class StateTest < Test::Unit::TestCase
  fixtures :countries, :states
  include UnitSimple
  
  def setup
    @state = %w(sinaloa nuevo_leon)
  end

  def test_crud 
    crud_test(@state, State)
  end

  def test_validation
    validate_test(@state, State)
  end

  def test_collision
    collision_test(@state, State)
  end
end
