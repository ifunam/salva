require File.dirname(__FILE__) + '/../test_helper'
require 'state'
require 'city'
class CityTest < Test::Unit::TestCase
  fixtures :states, :cities
  include UnitSimple
  
  def setup
    @city = %w(culiacan monterrey)
  end

  def test_crud 
    crud_test(@city, City)
  end

  def test_validation
    validate_test(@city, City)
  end

  def test_collision
    collision_test(@city, City)
  end
end
