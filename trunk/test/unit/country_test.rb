require File.dirname(__FILE__) + '/../test_helper'
require 'country'

class CountryTest < Test::Unit::TestCase
  fixtures :countries
  include UnitSimple

  def setup
    @country = %w(mexico japan ukrania)
  end

  def test_crud 
    crud_test(@country, Country)
  end

  def test_validation
    validate_test(@country, Country)
  end

#  def test_collision
#    collision_test(@country, Country)
#  end
end
