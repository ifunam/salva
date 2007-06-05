require File.dirname(__FILE__) + '/../test_helper'
require 'country'
require 'state'
require 'city'
class CityTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities
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

   def test_validate_states_with_bad_values

     # Checking constraints for ID
     @city = City.new({:name => 'Los mochis', :state_id => 19})

     # Non numeric ID 
     @city.state_id = 'xx'
     assert !@city.valid?

     # Nil ID 
     @city.state_id = nil
     assert !@city.valid?

     # Negative number ID 
     @city.state_id = -1
     assert !@city.valid?

     # Too long number ID 
     @city.state_id = 10001
     assert !@city.valid?

     @city.id = 999
     # Checking constraints for name
     # Nil name
     @city.name = nil
     assert !@city.valid?
     @city.name = 'Chiapas'
   end

   def test_check_uniqueness
     @city = City.new({:name => 'Los mochis', :state_id => 19})
     assert @city.save

     @city2 = City.new({:name => 'Los mochis', :state_id => 19})
     assert !@city2.save
   end
end
