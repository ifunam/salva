require File.dirname(__FILE__) + '/../test_helper'
require 'country'
require 'state'
class StateTest < Test::Unit::TestCase
  fixtures :countries, :states
  include UnitSimple
  
  def setup
    @states = %w(sinaloa nuevo_leon)
  end

  # Right - CRUD
   def test_crud 
     crud_test(@states, State)
   end

   def test_validation
     validate_test(@states, State)
   end

   def test_collision
     collision_test(@states, State)
   end

   def test_create_with_empty_attributes
     @state = State.new
     assert !@state.save
   end

   # Boundary
   def test_validate_states_with_bad_values

     # Checking constraints for ID
     @state = State.new({:name => 'Chiapas', :code => nil, :country_id => 484})
     assert @state.save

     # Non numeric ID 
     @state.country_id = 'xx'
     assert !@state.valid?
     # Nil ID 
     @state.country_id = nil
     assert !@state.valid?
     # Negative number ID 
     @state.country_id = -1
     assert !@state.valid?
     # Very large number for ID 
     @state.id = 10000
     assert !@state.valid?

     @state.id = 999
     # Checking constraints for name
     # Nil name
     @state.name = nil
     assert !@state.valid?
     @state.name = 'Chiapas'

     # Checking uniqueness for name and country_id
     @state2 = State.new({:name => 'Chiapas', :code => nil, :country_id => 484})
     assert !@state2.save
   end


end
